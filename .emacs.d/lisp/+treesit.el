;; lisp/+treesit.el --- TreeSit -*- lexical-binding: t; -*-

;; Tree Sitter
;; Just using tree sitter to typst mode, because typst-mode
;; has been deprecated... So that's it.
;; Tree sitter in emacs is really incompleted... 'treesit'
(dolist (grammar '((typst "https://github.com/uben0/tree-sitter-typst.git")
                   (gleam "https://github.com/gleam-lang/tree-sitter-gleam.git")))
  (add-to-list 'treesit-language-source-alist grammar))

;; Need to download the grammar...
(straight/require
 '(typst-ts-mode :type git :host nil
                 :repo "https://codeberg.org/meow_king/typst-ts-mode"
                 :files (:defaults "*.el")))
(setq typst-ts-mode-enable-raw-blocks-highlight t)

(straight/require 'gleam-ts-mode)
(add-to-list 'auto-mode-alist '("\\.gleam\\'" . gleam-ts-mode))

(provide '+treesit)
