;; lisp/+langs.el --- Langs Config -*- lexical-binding: t; -*-

;; Code:
(straight/require 'apheleia)
(apheleia-global-mode)

(require '+lsp)
(straight/require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(straight/require 'go-mode)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-hook 'go-mode-hook 'lsp-deferred)

(straight/require 'rust-mode)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(straight/require 'haskell-mode)
(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))

(straight/require 'lua-mode)
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))

(straight/require ;; This need java of course
 '(plantuml-mode :type git :host nil :repo "https://github.com/skuro/plantuml-mode"
                 :pre-build ("wget" "https://github.com/plantuml/plantuml/releases/download/v1.2025.1/plantuml-gplv2-1.2025.1.jar")))
(setq plantuml-jar-path "~/.emacs.d/straight/repos/plantuml-mode/plantuml-gplv2-1.2025.1.jar")
(setq plantuml-default-exec-mode 'jar)
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))

(straight/require ;; Thanks again tsoding
 '(simpc-mode :type git :host nil :repo "https://github.com/rexim/simpc-mode"))
(add-to-list 'auto-mode-alist '("\\.\\(c\\|cpp\\|h\\)\\'" . simpc-mode))
(setf (alist-get 'simpc-mode apheleia-mode-alist) '(clang-format))

(straight/require 'restclient) ;; trying this to replace postman
(add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))

(provide '+langs)
