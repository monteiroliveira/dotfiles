(setq inhibit-splash-screen t
      indent-tabs-mode nil)
(setq tab-width 4)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq custom-file "~/.emacs.d/custom.el")
(load-file custom-file)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/lisp/builtin")

(require '+straight)

(require '+misc)
(require '+completion)
(require '+org)
(require '+langs)
