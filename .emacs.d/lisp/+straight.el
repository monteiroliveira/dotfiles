;;; lisp/+straight.el --- Give me Straight.el -*- lexical-binding: t; -*-

;;; Code:
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(defun straight/require (&rest recipes)
  "Use 'straight-use-package' to ensure the RECIPE (or just pkg), then call require."
  (interactive "sEnter package name: ")
  (dolist (recipe recipes)
    (when (stringp recipe)
      (setq recipe (intern recipe)))
    (when (eval `(straight-use-package ',recipe))
      (let ((pkg (if (consp recipe)
		             (car recipe)
		           recipe)))
        (eval `(require ',pkg))))))

(provide '+straight)
