;;; lisp/gmo-shells.el --- Install config vterm and configure eshell and vterm -*- lexical-binding: t; -*-

;;; Code:
(setup (:pkg vterm)
  (:option shell-file-name "/usr/bin/fish"
	   shell-max-scrollback 5000))

(setup eshell
  (:option eshell-history-size 5000
	   eshell-beffer-maximum-lines 5000
	   eshell-scroll-to-bottom-on-input t
	   eshell-highlight-prompt t))

(provide 'gmo-shells)
