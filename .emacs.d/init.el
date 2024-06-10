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

;; (global-prettify-symbols-mode t)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(defalias 'yes-or-no-p 'y-or-n-p) ;; Turn 'yes' or 'no' question to 'y' or 'n'

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 135)

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

(require '+straight)
(require '+setup)
(require '+ui)
(require '+misc)
(require '+evil)
(require '+org)
(require '+completion)
(require '+shells)
(require '+langs)
(require '+keybinds)
