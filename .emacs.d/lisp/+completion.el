;; lisp/+completion.el --- Completion -*- lexical-binding: t; -*-

;; Code:
(straight/require 'vertico)
(straight/require 'marginalia)
(straight/require 'consult)
(straight/require 'prescient)
(straight/require 'vertico-prescient)
(straight/require 'company-prescient)

(require 'savehist)
(setq history-length 25)
(savehist-mode)

(setq vertico-cycle t)
(vertico-mode)
(marginalia-mode)

(define-key vertico-map (kbd "C-<backspace>") 'vertico-directory-up) ;; Hmmm...

(global-set-key (kbd "C-s") 'consult-line)

(global-set-key (kbd "C-x C-b") 'consult-buffer)
(global-set-key (kbd "C-x b") 'consult-buffer)

(with-eval-after-load 'vertico
  (vertico-prescient-mode))

(straight/require 'company)
(straight/require 'company-box)

(setq company-minimum-prefix-length 2
      company-idle-delay 0.2)

(add-hook 'company-mode-hook 'company-box-mode)

(global-company-mode)

(with-eval-after-load 'company
  (company-prescient-mode))

(straight/require 'yasnippet)
(yas-global-mode)

(provide '+completion)
