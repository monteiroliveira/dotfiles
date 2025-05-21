;; lisp/+misc.el --- Micellaneous -*- lexical-binding: t; -*-

;; Code:
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(defun misc/get-default-font ()
  "Sometimes we need to do things we are not much proud"
  (cond
   ((eq system-type 'windows-nt) "Consolas-18")
   ((eq system-type 'gnu/linux) "Iosevka Nerd Font-18")))

;; (set-face-attribute 'default nil :font "Iosevka Nerd Font" :height 140)
;; (set-face-attribute 'font-lock-comment-face nil :slant 'italic)
;; (set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

(dolist (fc `((font . ,(misc/get-default-font))
              (height . 130)))
  (add-to-list 'default-frame-alist fc))

;; God mode; Most used in emacs -nw to avoid key conflicts
(straight/require 'god-mode)
(when (not (display-graphic-p))
  (god-mode))
(global-set-key (kbd "C-c g") #'god-local-mode)

(straight/require 'hydra)
(global-set-key
 (kbd "C-x w w")
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

(defun misc/enable-whitespaces-mode ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions
               'delete-trailing-whitespace))
(add-hook 'prog-mode-hook 'misc/enable-whitespaces-mode)

(straight/require 'paredit)
(defun misc/enable-paredit-mode ()
  (interactive)
  (paredit-mode))

(straight/require 'undo-tree)
(setq undo-tree-auto-save-history nil)
(global-undo-tree-mode)

(straight/require 'magit)
(global-set-key (kbd "C-x m") 'magit) ;; need to look more of this.
(global-set-key (kbd "C-c m l") 'magit-log)
(global-set-key (kbd "C-c m s") 'magit-status)

(require 'compile)
(setq compilation-scroll-output t)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c p f") 'find-grep)

(require 'project)

(straight/require 'expand-region)
(global-set-key (kbd "C-c v w") 'er/mark-word)
(global-set-key (kbd "C-c v i \"") 'er/mark-inside-quotes)
(global-set-key (kbd "C-c v a \"") 'er/mark-outside-quotes)
(global-set-key (kbd "C-c v i )") 'er/mark-inside-pairs)
(global-set-key (kbd "C-c v a )") 'er/mark-outside-pairs)
(global-set-key (kbd "C-c v i (") 'er/mark-inside-pairs)
(global-set-key (kbd "C-c v a (") 'er/mark-outside-pairs)

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

(straight/require 'rainbow-mode)
;; (rainbow-mode)

(straight/require 'gruber-darker-theme) ;; Thanks tsoding
(load-theme 'mruber-darker t)

(global-hl-line-mode)

(provide '+misc)
