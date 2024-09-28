;;; lisp/+org.el --- Org mode -*- lexical-binding: t; -*-

;;; Code:
(setup (:pkg org)
  (:also-load org-tempo)
  ;; (:option org-edit-src-content-indentation 0)
  (:hook org-indent-mode toc-org-mode)

  (setup org-tempo
    (:when-loaded
      (add-to-list
       'org-structure-template-alist '("el" . "SRC emacs-lisp"))))

  (setup (:pkg toc-org))

  (setup (:pkg org-roam))

  (eval-after-load "org-indent"
    '(progn
       (:diminish org-indent-mode))))

(provide '+org)
