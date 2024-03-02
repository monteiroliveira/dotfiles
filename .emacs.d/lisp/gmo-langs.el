;;; lisp/gmo-langs.el --- Install and configure lsp and many p langs -*- lexical-binding: t; -*-

;;; Code:
(setup (:pkg lsp-mode)
  (:option lsp-headerline-breadcrumb-enable nil)
  (eval-after-load "lsp-lens"
    '(progn
       (:diminish lsp-lens-mode))))

(setup (:pkg lsp-ui))

(setup (:pkg haskell-mode)
  (setup (:pkg lsp-haskell))
  (:file-match "\\.hs\\'")
  (:hook lsp))

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

(provide 'gmo-langs)
