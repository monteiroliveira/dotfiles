;; lisp/+completion.el --- Completion -*- lexical-binding: t; -*-

;; Code:
(require 'savehist)
(setq history-length 25)
(savehist-mode)

(straight/require 'ido-completing-read+)
(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(straight/require 'smex)
(global-set-key (kbd "M-x") 'smex)

;; (straight/require 'vertico)
;; (straight/require 'vertico-prescient)

;; (setq vertico-cycle t)
;; (vertico-mode)
;; (vertico-flat-mode) ;; Turn vertico like ido

;; (with-eval-after-load 'vertico
;;   (vertico-prescient-mode))
;; (define-key vertico-map (kbd "C-<backspace>") 'vertico-directory-up) ;; Hmmm...

;; (straight/require 'consult)
;; (global-set-key (kbd "C-s") 'consult-line)
;; (global-set-key (kbd "C-x b") 'consult-buffer)
;; (global-set-key (kbd "C-x c f") 'consult-fd)
;; (global-set-key (kbd "C-x c s") 'consult-ripgrep)

(straight/require 'prescient)
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
