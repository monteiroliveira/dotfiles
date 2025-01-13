;; lisp/+langs.el --- Langs Config -*- lexical-binding: t; -*-

;; Code:
(straight/require 'apheleia)
(apheleia-global-mode)

(straight/require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(straight/require 'go-mode)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

(straight/require 'rust-mode)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(straight/require 'haskell-mode)
(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))

(straight/require ;; Thanks again tsoding
 '(simpc-mode :type git :host nil :repo "https://github.com/rexim/simpc-mode"))
(add-to-list 'auto-mode-alist '("\\.\\(c\\|cpp\\|h\\)\\'" . simpc-mode))

;; Tree Sitter
;; Just using tree sitter to typst mode, because typst-mode
;; has been deprecated... So that's it.
;; Tree sitter in emacs is really incompleted... 'treesit'
(add-to-list 'treesit-language-source-alist
			 '(typst "https://github.com/uben0/tree-sitter-typst.git"))

;; Need to download the grammar...
(straight/require
 '(typst-ts-mode :type git :host nil
				 :repo "https://codeberg.org/meow_king/typst-ts-mode"
				 :files (:defaults "*.el")))
(setq typst-ts-mode-enable-raw-blocks-highlight t)

(provide '+langs)
