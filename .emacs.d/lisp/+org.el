;;; lisp/+org.el --- Org mode -*- lexical-binding: t; -*-

;;; Code:
(setup (:pkg org)
  (:also-load org-tempo)
  (:option org-edit-src-content-indentation 0)
  (:hook org-indent-mode toc-org-mode)
  (eval-after-load "org-indent"
    '(progn
       (:diminish org-indent-mode))))

(setup org-tempo
  (:when-loaded (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))))

(setup (:pkg toc-org))

(provide '+org)
