;; lisp/+completion.el --- Completion -*- lexical-binding: t; -*-

;; Code:
(straight/require 'prescient)

(require 'savehist)
(setq history-length 25)
(savehist-mode)

(straight/require 'vertico)
(straight/require 'vertico-prescient)

(setq vertico-cycle t)
(vertico-mode)
(vertico-flat-mode) ;; Turn vertico like ido

(with-eval-after-load 'vertico
  (vertico-prescient-mode))

(define-key vertico-map (kbd "C-<backspace>") 'vertico-directory-up) ;; Hmmm...

(straight/require 'marginalia)
(marginalia-mode)

(straight/require 'consult)
(global-set-key (kbd "C-s") 'consult-line)
(global-set-key (kbd "C-x C-b") 'consult-buffer)
(global-set-key (kbd "C-x b") 'consult-buffer)

(straight/require 'company)
(straight/require 'company-prescient)
;; (straight/require 'company-box)
;; (add-hook 'company-mode-hook 'company-box-mode)

(setq company-minimum-prefix-length 2
      company-idle-delay 0.2)

(global-company-mode)

(with-eval-after-load 'company
  (company-prescient-mode))

(straight/require 'yasnippet)
(yas-global-mode)

(provide '+completion)
