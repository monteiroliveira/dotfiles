;;; lisp/+shells.el --- Shells config -*- lexical-binding: t; -*-

;;; Code:
(setup (:pkg vterm)
  (:option shell-file-name "/bin/bash"
	   shell-max-scrollback 5000))

(setup eshell
  (:option eshell-history-size 5000
	   eshell-beffer-maximum-lines 5000
	   eshell-scroll-to-bottom-on-input t
	   eshell-highlight-prompt t))

(provide '+shells)
