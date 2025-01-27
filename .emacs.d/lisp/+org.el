(straight/require 'org)
(straight/require 'org-roam)
(straight/require 'toc-org)
(require 'org-tempo)
(require 'org-indent)

(setq org-edit-src-content-indentation 0)
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'toc-org-mode)

(add-to-list 'org-structure-template-alist
             '("el" . "SRC emacs-lisp"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((latex . t)))

(provide '+org)
