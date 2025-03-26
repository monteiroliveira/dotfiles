;; lisp/+lsp.el --- LSP Config -*- lexical-binding: t; -*-

;; Code
(straight/require 'lsp-mode)
(setq lsp-keymap-prefix "C-c l")

(straight/require 'consult-lsp)

(straight/require 'dap-mode)

(provide '+lsp)
