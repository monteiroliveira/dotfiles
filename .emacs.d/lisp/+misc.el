;;; lisp/+misc.el --- miscellaneous (things i don't know where to put) -*- lexical-binding: t; -*-

(setup (:pkg undo-tree)
  (:diminish)
  (:option undo-tree-auto-save-history nil)
  (global-undo-tree-mode 1))

(setup eldoc (:diminish))

(provide '+misc)
