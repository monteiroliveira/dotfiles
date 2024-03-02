;; -*- lexical-binding: t; -*-
(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(global-prettify-symbols-mode t)

(defalias 'yes-or-no-p 'y-or-n-p) ;; Turn 'yes' or 'no' question to 'y' or 'n'

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(setq make-backup-files nil)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq modus-themes-mode-line '(borderless)
      modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-headings '((t . (rainbow))))
(load-theme 'modus-vivendi t)

(set-face-attribute 'default nil :font "FantasqueSansM Nerd Font Mono" :height 135)

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

(require 'gmo-straight)
(require 'gmo-setup)

(setup eldoc
  (:diminish))

(setup (:pkg undo-tree)
  (:diminish)
  (:option undo-tree-auto-save-history nil)
  (global-undo-tree-mode 1))

(setup (:pkg which-key)
  (:diminish)
  (:option which-key-idle-delay 0.3)
  (which-key-mode))

(setup LaTex-mode)

(setup (:pkg auctex))

(setup (:pkg apheleia))

(require 'gmo-evil)
(require 'gmo-org)
(require 'gmo-completion)
(require 'gmo-shells)
(require 'gmo-langs)
(require 'gmo-keybinds)
