;; lisp/+lsp.el --- LSP Config -*- lexical-binding: t; -*-

;; Code
(straight/require 'lsp-mode)
(setq lsp-keymap-prefix "C-c l"
      lsp-headerline-breadcrumb-enable nil
      lsp-modeline-code-actions-enable nil
      lsp-lens-enable nil)
(add-to-list 'lsp-language-id-configuration '(simpc-mode . "c"))

(straight/require 'dap-mode)

(defun lsp/enable-lsp-session ()
  "Enable `lsp-deferred` from the current major mode's hook and revert buffer."
  (interactive)
  (eval-after-load 'lsp-mode
    '(progn
       (let ((hook (intern (concat (symbol-name major-mode) "-hook"))))
         (if (not (member 'lsp-deferred (symbol-value hook)))
             (progn
               (add-hook (intern (concat (symbol-name major-mode) "-hook")) 'lsp-deferred)
               (revert-buffer nil :noconfirm)))))))
(global-set-key (kbd "C-c l e") 'lsp/enable-lsp-session)

(defun lsp/disable-lsp-session ()
  "Disable `lsp-deferred` from the current major mode's hook and revert buffer."
  (interactive)
  (eval-after-load 'lsp-mode
    '(progn
       (let ((hook (intern (concat (symbol-name major-mode) "-hook"))))
         (if (member 'lsp-deferred (symbol-value hook))
             (progn
               (message "Remove 'lsp-deferred' from %s" hook)
               (remove-hook hook 'lsp-deferred)
               (revert-buffer nil :noconfirm)))))))
(global-set-key (kbd "C-c l E") 'lsp/disable-lsp-session)

(provide '+lsp)
