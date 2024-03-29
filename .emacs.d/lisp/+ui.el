;;; lisp/+ui.el --- UI Config and enhancements -*- lexical-binding: t; -*-

(setup (:pkg which-key)
  (:diminish)
  (:option which-key-idle-delay 0.3)
  (which-key-mode))

(setup (:pkg neotree)
  (:option neo-smart-open t
	   neo-show-hidden-files t))

(provide '+ui)
