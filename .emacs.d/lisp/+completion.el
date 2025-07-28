;; lisp/+completion.el --- Completion -*- lexical-binding: t; -*-

;; Code:
(require 'savehist)
(setq history-length 25)
(savehist-mode)

(straight/require 'ido-completing-read+)
(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)
(setq ido-enable-flex-matching t)

(straight/require 'smex)
(global-set-key (kbd "M-x") 'smex)

(straight/require 'prescient)
(straight/require 'company)
(straight/require 'company-prescient)

(setq company-minimum-prefix-length 2
      company-idle-delay 0.2)
(global-company-mode)

(with-eval-after-load 'company
  (company-prescient-mode))

(straight/require 'yasnippet)
(yas-global-mode)

(provide '+completion)
