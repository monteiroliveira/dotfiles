;; lisp/builtin/textm.el --- Text Manipulation -*- lexical-binding: t; -*-

;; Module focused on manipulation text function, like clone line, move text
;; or region...

;; Code:
(defun textm/build-prefix-list ()
  "To avoid \"The mark is not set now, so there is no region\"
using the \"r\" flag in 'interactive' this function build a list
with the argumensts to move-text function without any region erros."
  (list
   (prefix-numeric-value current-prefix-arg)
   (when (use-region-p) (region-beginning))
   (when (use-region-p) (region-end))))

(defun textm/duplicate-line ()
  "Duplicate line and put the cursor in the same position one line below"
  (interactive)
  (let ((column (- (point) (line-beginning-position)))
	(line (let ((s (thing-at-point 'line t)))
		(when s (string-remove-suffix "\n" s)))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(defun textm/delete-line ()
  "Delete current line."
  (interactive)
  (let ((line (thing-at-point 'line t)))
    (move-beginning-of-line 1)
    (kill-line 1)
    (kill-new line)))

(defun textm/move-line (n)
  "Move line up or down by N lines"
  (let ((column (- (point) (line-beginning-position)))
	(line-beginning (line-beginning-position))
	(line-ending (+ (line-end-position) 1)))
    (let ((line-text
	   (delete-and-extract-region line-beginning line-ending)))
      (forward-line n)
      (insert line-text)
      (forward-line -1)
      (forward-char column)
      (indent-region line-beginning line-ending))))

(defun textm/move-line-up (n)
  (interactive "p")
  (textm/move-line (if (null n) -1 (- n))))

(defun textm/move-line-down (n)
  (interactive "p")
  (textm/move-line (if (null n) 1 n)))

(defun textm/move-region (n begin end)
  "Move a region by N lines and recreate the region by the
forward lines + length of text lines using \"region context\""
  (interactive "p\nr")
  (let ((line-text (delete-and-extract-region begin end)))
    (forward-line n)
    (let ((beg (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark beg))))

(defun textm/move-region-up (n begin end)
  (interactive "p\nr")
  (textm/move-region (if (null n) -1 (- n)) begin end))

(defun textm/move-region-down (n begin end)
  (interactive "p\nr")
  (textm/move-region (if (null n) 1 n) begin end))

(defun textm/move-text-up (n &optional begin end)
  (interactive (textm/build-prefix-list))
  (if (region-active-p)
      (textm/move-region-up n begin end)
    (textm/move-line-up n)))

(defun textm/move-text-down (n &optional begin end)
  (interactive (textm/build-prefix-list))
  (if (region-active-p)
      (textm/move-region-down n begin end)
    (textm/move-line-down n)))

(provide 'textm)
