;;; lisp/+completion.el --- Completion enhancements  -*- lexical-binding: t; -*-

;;; Code:
(setup savehist
  (:option history-lenght 25)
  (savehist-mode))

(setup (:pkg vertico)
  (:with-map vertico-map
    (:bind "C-j" vertico-next
	   "C-k" vertico-previous))
  (:option vertico-cycle t)
  (vertico-mode))

(setup (:pkg marginalia)
  (marginalia-mode))

(setup (:pkg consult)
  (:global "C-s" consult-line
	   "C-M-l" consult-imenu)
  (:with-map minibuffer-local-map
    (:bind "C-r" consult-history)))

(setup (:pkg embark)
  (:also-load embark-consult)
  (:global "C-S-a" embark-act)
  (:with-map minibuffer-local-map
    (:bind "C-d" embark-act)))

(setup (:pkg embark-consult))

(setup (:pkg orderless)
  (:require)
  (:option completion-styles '(orderless basic)
	   completion-category-defaults nil
	   completion-category-overrides '((file (styles partial-completion)))))

(setup (:pkg corfu)
  (:option corfu-cycle t
	   corfu-auto t
	   corfu-auto-prefix 2
	   corfu-auto-delay 0.0
	   corfu-styles '(orderless-fast basic))
  (:with-map corfu-map
    (:bind "C-j" corfu-next
	   "C-k" corfu-previous
	   "TAB" corfu-insert
	   "C-f" corfu-insert))
  (global-corfu-mode))

(setup (:pkg company)
  (:disabled)
  (:diminish)
  (:option company-minimum-prefix-length 2
	   company-idle-delay nil)
  (:with-map company-active-map
    (:bind "TAB" company-complete-selection))
  (global-company-mode))

(setup (:pkg company-box)
  (:diminish)
  (:hook-into company-mode))

(provide '+completion)
