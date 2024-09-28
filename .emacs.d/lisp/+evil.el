;;; lisp/+evil.el --- Evil mode and addons -*- lexical-binding: t; -*-

;;; Code:
(setup (:pkg evil)
  (:option evil-want-integration t
	   evil-want-C-u-scroll t
	   evil-want-C-i-jump nil
	   evil-want-keybinding nil
	   evil-split-window-right t
	   evil-split-window-bellow t
	   evil-undo-system 'undo-tree)
  (:with-map (evil-normal-state-map
	      evil-motion-state-map)
    (:bind "C-u" (lambda () (interactive) (recenter) (evil-scroll-up 0))
	   "C-d" (lambda () (interactive) (recenter) (evil-scroll-down 0))))
  (evil-mode)

  (setup (:pkg evil-collection)
    (:load-after evil)
    (evil-collection-init)
    (eval-after-load "evil-collection-unimpaired"
      '(progn
	 (:diminish evil-collection-unimpaired-mode))))

  (setup (:pkg evil-mc)
    (:diminish)
    (:load-after evil)
    (global-evil-mc-mode 1))

  (setup (:pkg evil-multiedit)
    (:load-after evil)
    (evil-multiedit-default-keybinds))

  (setup (:pkg evil-commentary)
    (:load-after evil)
    (:with-map evil-normal-state-map
      (:bind "gc" evil-commentary)))

  (setup (:pkg evil-surround)
    (:diminish)
    (:load-after evil)
    (global-evil-surround-mode 1))

  (with-eval-after-load 'general
    (gmo/leader-keys
      "w"  '(:ignore t :wk "Windows")
      "wc" '(evil-window-delete :wk "Close current windows")
      "ws" '(evil-window-split :wk "Horizontal split")
      "wv" '(evil-window-vsplit :wk "Vertical split")
      "wh" '(evil-window-left :wk "Window left")
      "wj" '(evil-window-down :wk "Window down")
      "wk" '(evil-window-up :wk "Window up")
      "wl" '(evil-window-right :wk "Window right")
      "ww" '(evil-window-next :wk "Window next"))))

(provide '+evil)
