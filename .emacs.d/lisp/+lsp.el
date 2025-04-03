;; lisp/+lsp.el --- LSP Config -*- lexical-binding: t; -*-

;; Code
(straight/require 'lsp-mode)
(setq lsp-keymap-prefix "C-c l"
      lsp-headerline-breadcrumb-enable nil
      lsp-modeline-code-actions-enable nil
      lsp-lens-enable nil)

(straight/require 'dap-mode)

(provide '+lsp)
