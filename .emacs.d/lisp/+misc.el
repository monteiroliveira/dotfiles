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

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

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

(straight/require 'undo-tree)
(setq undo-tree-auto-save-history nil)
(global-undo-tree-mode)

(straight/require 'magit)

(require 'compile)
(setq compilation-scroll-output t)
(global-set-key (kbd "C-x C") 'compile)

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

(setq modus-themes-mode-line '(borderless)
      modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-headings '((t . (rainbow))))
(load-theme 'modus-vivendi t) ;; nice simple theme

(provide '+misc)
