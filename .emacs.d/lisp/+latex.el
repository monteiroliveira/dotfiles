;;; lisp/+latex.el --- Latex config with AuCTeX -*- lexical-binding: t; -*-

(setup (:pkg auctex)
  :require
  (require 'tex)
  (setq TeX-view-program-selection '(output-pdf "Zathura")))

(provide '+latex)
