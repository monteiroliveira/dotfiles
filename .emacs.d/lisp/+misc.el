;; lisp/+misc.el --- Micellaneous -*- lexical-binding: t; -*-

;; Code:
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(set-face-attribute 'default nil
                    :font "Iosevka Nerd Font" ;; Trying this instead
                    :height 140)

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)

(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

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

(straight/require 'diminish) ;; Some packages i don't need to know if is enabled
(diminish 'apheleia-mode)
(diminish 'undo-tree-mode)

(straight/require 'magit)
(global-set-key (kbd "C-x m") 'magit) ;; need to look more of this.

(require 'compile)
(setq compilation-scroll-output t)
(global-set-key (kbd "C-x c c") 'compile)

(global-set-key (kbd "C-x c f") 'consult-fd)
(global-set-key (kbd "C-x c s") 'consult-ripgrep)

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

(straight/require 'rainbow-mode)
;; (rainbow-mode)

(straight/require 'gruber-darker-theme) ;; Thanks tsoding
(load-theme 'mruber-darker t)

(global-hl-line-mode)

(provide '+misc)
