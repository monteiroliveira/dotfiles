;; lisp/+treesit.el --- TreeSit -*- lexical-binding: t; -*-

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

(provide '+treesit)
