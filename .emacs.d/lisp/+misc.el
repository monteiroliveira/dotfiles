;;; lisp/+misc.el --- miscellaneous (things i don't know where to put) -*- lexical-binding: t; -*-

(setup (:pkg undo-tree)
  (:diminish)
  (:option undo-tree-auto-save-history nil)
  (global-undo-tree-mode 1))

(setup (:pkg magit))

(setup eldoc (:diminish))

(setup (:pkg doom-themes))

;; (setq modus-themes-mode-line '(borderless)
;;       modus-themes-bold-constructs t
;;       modus-themes-italic-constructs t
;;       modus-themes-headings '((t . (rainbow))))
(load-theme 'doom-one t)

(provide '+misc)
