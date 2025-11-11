(straight/require 'org)
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

(add-to-list
 'org-src-lang-modes '("plantuml" . plantuml))

(straight/require 'visual-fill-column)
(setq-default visual-fill-column-width 120
              visual-fill-column-center-text t)

(straight/require 'org-roam)
(org-roam-complete-everywhere)

(provide '+org)
