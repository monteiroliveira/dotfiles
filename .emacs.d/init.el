;; -*- lexical-binding: t; -*-
(setq inhibit-startup-message t
      display-line-numbers-type 'relative
      make-backup-files nil)

(set-default-coding-systems 'utf-8)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(global-display-line-numbers-mode 1)

(global-prettify-symbols-mode t)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(defalias 'yes-or-no-p 'y-or-n-p) ;; Turn 'yes' or 'no' question to 'y' or 'n'

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
(require 'gmo-ui)

(setup eldoc (:diminish))

(setup (:pkg undo-tree)
  (:diminish)
  (:option undo-tree-auto-save-history nil)
  (global-undo-tree-mode 1))

(setup (:pkg apheleia))

(require 'gmo-evil)
(require 'gmo-org)
(require 'gmo-completion)
(require 'gmo-shells)
(require 'gmo-langs)
(require 'gmo-keybinds)
