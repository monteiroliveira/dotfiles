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
    (:bind "C-r" consult-history))

  (with-eval-after-load 'general
    (gmo/leader-keys
      "ht" '(consult-theme :wk "Load theme")
      "bi" '(consult-buffer :wk "Ibuffer"))

    (gmo/leader-keys
      "p"  '(:ignore t :wk "Project")
      "pf" '(consult-fd :wk "Project file")
      "ps" '(consult-ripgrep :wk "Project search")
      "pg" '(consult-git-grep :wk "Project git search")
      "pi" '(consult-imenu :wk "Project imenu search")
      "pl" '(consult-line :wk "project line search"))))

;; (setup (:pkg embark)
;;   (:also-load embark-consult)
;;   (:global "C-S-a" embark-act)
;;   (:with-map minibuffer-local-map
;;     (:bind "C-d" embark-act)))

;; (setup (:pkg embark-consult))

;; (setup (:pkg orderless)
;;   (:require)
;;   (:option completion-styles '(orderless basic)
;;            completion-category-defaults nil
;;            completion-category-overrides '((file (styles partial-completion)))))

(setup (:pkg company)
  (:diminish)
  (:option company-minimum-prefix-length 2
	   company-idle-delay 0.2)
  (:with-map company-active-map
    (:bind "TAB" company-complete-selection))
  (global-company-mode)

  (setup (:pkg company-box)
    (:diminish)
    (:hook-into company-mode))

  ;; Backends
  (setup (:pkg company-auctex)
    (:require)
    (:load-after company)
    (company-auctex-init)))

(setup (:pkg prescient)
  (:load-after vertigo company)

  (setup (:pkg vertico-prescient)
    (vertico-prescient-mode))

  (setup (:pkg company-prescient)
    (company-prescient-mode)))

(setup (:pkg yasnippet))

(provide '+completion)
