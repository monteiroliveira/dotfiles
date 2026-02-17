;; lisp/+misc.el --- Micellaneous -*- lexical-binding: t; -*-

;; Code:
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(defun misc/get-default-font ()
  "Sometimes we need to do things we are not much proud"
  (cond
   ((eq system-type 'windows-nt) "Consolas-18")
   ((eq system-type 'gnu/linux) "Iosevka Nerd Font-20")))

(dolist (fc `((font . ,(misc/get-default-font))))
  (add-to-list 'default-frame-alist fc))

;; TODO: adjust this center when scrolling down
(defun misc/scroll-recenter-down ()
  "Scroll the screen \"up\" and move the cursor to the center"
  (interactive)
  (scroll-up-command)
  (recenter))
(global-set-key (kbd "C-v") 'misc/scroll-recenter-down)

(defun misc/scroll-recenter-up ()
  "Scroll the screen \"down\" and move the cursor to the center"
  (interactive)
  (scroll-down-command)
  (recenter))
(global-set-key (kbd "M-v") 'misc/scroll-recenter-up)

(defun misc/enable-whitespaces-mode ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions
               'delete-trailing-whitespace))
;; (add-hook 'prog-mode-hook 'misc/enable-whitespaces-mode)

(straight/require 'paredit)
(defun misc/enable-paredit-mode ()
  (interactive)
  (paredit-mode))

(straight/require 'undo-tree)
(setq undo-tree-auto-save-history nil)
(global-undo-tree-mode)

(require '+magit)

(require 'compile)
(setq compilation-scroll-output t)

(require 'ansi-color)
(defun misc/colorize-compilation-buffer ()
  (read-only-mode 'toggle)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (read-only-mode 'toggle))
(add-hook 'compilation-filter-hook 'misc/colorize-compilation-buffer)

(global-set-key (kbd "C-c c") 'compile)

(require 'project)

(straight/require 'expand-region)
(global-set-key (kbd "C-c v w") 'er/mark-word)
(global-set-key (kbd "C-c v i \"") 'er/mark-inside-quotes)
(global-set-key (kbd "C-c v a \"") 'er/mark-outside-quotes)

(global-set-key (kbd "C-c v i (") 'er/mark-inside-pairs)
(global-set-key (kbd "C-c v a (") 'er/mark-outside-pairs)
(global-set-key (kbd "C-c v i )") 'er/mark-inside-pairs)
(global-set-key (kbd "C-c v a )") 'er/mark-outside-pairs)

(require 'textm)
(global-set-key (kbd "C-,") 'textm/duplicate-line)

(global-set-key (kbd "C-;") 'textm/delete-line)

(global-set-key (kbd "M-p") 'textm/move-text-up)
(global-set-key (kbd "M-n") 'textm/move-text-down)

(straight/require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)

(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this-dwim)

(straight/require 'rainbow-mode)

(straight/require 'gruber-darker-theme) ;; Thanks tsoding
(load-theme 'mruber-darker t)

(global-set-key (kbd "C-c b r")
                (lambda()
                  (interactive)
                  (revert-buffer nil :noconfirm)))

(provide '+misc)
