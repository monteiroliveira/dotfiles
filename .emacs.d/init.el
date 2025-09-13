(setq-default inhibit-splash-screen t
              indent-tabs-mode nil
              make-backup-files nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(delete-selection-mode)

(setq custom-file "~/.emacs.d/custom.el")
(load-file custom-file)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/lisp/builtin")
(add-to-list 'custom-theme-load-path "~/repos/mruber-darker-theme.git/master/")

(require '+straight)

(require '+misc)
(require '+completion)
(require '+org)
(require '+langs)
(require '+treesit)

(global-font-lock-mode -1)
(add-hook 'dired-mode-hook 'font-lock-mode)
(add-hook 'magit-mode-hook 'font-lock-mode)

(straight/require 'diminish) ;; Some packages i don't need to know if is enabled
(diminish 'apheleia-mode)
(diminish 'undo-tree-mode)
