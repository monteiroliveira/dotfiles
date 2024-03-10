;;; lisp/gmo-ui.el --- UI Config -*- lexical-binding: t; -*-

(setup (:pkg which-key)
  (:diminish)
  (:option which-key-idle-delay 0.3)
  (which-key-mode))

(setup (:pkg neotree)
  (:option neo-smart-open t
	   neo-show-hidden-files t))

(provide 'gmo-ui)
