;; lisp/+misc.el --- Micellaneous -*- lexical-binding: t; -*-

;; Code:
(defalias 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil)

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(set-face-attribute 'default nil
					:font "Iosevka Nerd Font" ;; Trying this instead Jetbrains
					:height 140)

(set-face-attribute 'font-lock-comment-face nil
					:slant 'italic)

(set-face-attribute 'font-lock-keyword-face nil
					:slant 'italic)

;; (global-set-key (kbd "C-=") 'text-scale-increase)
;; (global-set-key (kbd "C--") 'text-scale-decrease)

;; Unbind kill-regin from c-w
(global-set-key (kbd "C-S-k") 'kill-region)

;; I think i need to move thin to another session
(define-prefix-command 'window-control)
(global-set-key (kbd "C-w") 'window-control)

(straight/require 'hydra)
(global-set-key
 (kbd "C-w C-w")
 (defhydra hydra-window-control ()
   ("v" split-window-right "vsplit")
   ("s" split-window-below "split")
   ("p" windmove-up "up")
   ("n" windmove-down "down")
   ("f" windmove-right "right")
   ("b" windmove-left "left")
   ("d" delete-window "delete")
   (">" shrink-window-horizontally)
   ("<" enlarge-window-horizontally)
   ("q" nil "quit")))

(global-set-key (kbd "C-w v") 'split-window-right)
(global-set-key (kbd "C-w s") 'split-window-below)
(global-set-key (kbd "C-w p") 'windmove-up)
(global-set-key (kbd "C-w n") 'windmove-down)
(global-set-key (kbd "C-w f") 'windmove-right)
(global-set-key (kbd "C-w b") 'windmove-left)
;; (global-set-key (kbd "M-w") 'shrink-window-horizontally)
;; (global-set-key (kbd "M-W") 'enlarge-window-horizontally)

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
(global-set-key (kbd "C-S-v") 'misc/scroll-recenter-up)

(defun misc/enable-whitespaces ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(straight/require 'undo-tree)
(setq undo-tree-auto-save-history nil)
(global-undo-tree-mode)

(straight/require 'magit)
(global-set-key (kbd "C-x m") 'magit) ;; need to look more of this.

(require 'compile)
(setq compilation-scroll-output t)
(global-set-key (kbd "C-x c c") 'compile)

(global-set-key (kbd "C-x c f") 'consult-fd)
(global-set-key (kbd "C-x c s") 'consult-grep)

(straight/require 'expand-region)
(define-prefix-command 'expand-mark-region)
(global-set-key (kbd "C-=") 'expand-mark-region)

(global-set-key (kbd "C-= w") 'er/mark-word)
(global-set-key (kbd "C-= i \"") 'er/mark-inside-quotes)
(global-set-key (kbd "C-= a \"") 'er/mark-outside-quotes)
(global-set-key (kbd "C-= i )") 'er/mark-inside-pairs)
(global-set-key (kbd "C-= a )") 'er/mark-outside-pairs)
(global-set-key (kbd "C-= i (") 'er/mark-inside-pairs)
(global-set-key (kbd "C-= a (") 'er/mark-outside-pairs)

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

(straight/require 'gruber-darker-theme) ;; Thanks tsoding
(load-theme 'gruber-darker t)

(global-hl-line-mode)

(setq modus-themes-mode-line '(borderless)
      modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-headings '((t . (rainbow))))
;; (load-theme 'modus-vivendi t) ;; nice simple theme

(provide '+misc)
