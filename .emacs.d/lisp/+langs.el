;;; lisp/+langs.el --- Langs configs and enhancements -*- lexical-binding: t; -*-

;;; Code:
(setup (:pkg lsp-mode)
  (:option lsp-headerline-breadcrumb-enable nil)
  (eval-after-load "lsp-lens"
    '(progn
       (:diminish lsp-lens-mode))))

(setup (:pkg lsp-ui))

(setup (:pkg haskell-mode)
  (setup (:pkg lsp-haskell))
  (:hook lsp)
  (:file-match "\\.hs\\'"))

(setup (:pkg rust-mode)
  (:file-match "\\.rs\\'")
  (:hook lsp))

(setup c-mode
  (:hook lsp))

(setup c++-mode
  (:hook lsp))

(setup (:pkg go-mode)
  (:file-match "\\.go\\'")
  (:hook lsp))

(setup LaTeX-mode
  (setup (:pkg lsp-latex))
  (:hook lsp)
  (setup (:pkg auctex)))

(setup (:pkg python-mode)
  (setup (:pkg lsp-pyright))
  (:file-match "\\.py\\'")
  (:hook lsp))

(setup (:pkg js2-mode)
  (:file-match "\\.js\\'")
  (:hook lsp))

(setup (:pkg rjsx-mode))

(setup (:pkg typescript-mode)
  (:file-match "\\.ts\\'")
  (:hook lsp))

(setup (:pkg web-mode)
  (:file-match "\\.\\(html?\\|css\\|ejs\\|jsx\\|tsx\\)\\'"))

(setup (:pkg apheleia)
  (:diminish)
  (:require apheleia)
  (setf (alist-get 'ormolu apheleia-formatters)
	'("ormolu" "--no-cabal" "--stdin-input-file" filepath))
  (setf (alist-get 'haskell-mode apheleia-mode-alist) ;; Using ormolu because brittany is unmaintained
	'ormolu)
  (apheleia-global-mode +1))

(provide '+langs)
