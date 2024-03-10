;;; lisp/gmo-keybinds.el --- Configure emacs keybinds using general.el -*- lexical-binding: t; -*-

;;; Code:
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(setup (:pkg general)
  (general-evil-setup t)
  (general-create-definer gmo/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

  (gmo/leader-keys
    "SPC" '(M-x :wk "M-x")
    "."   '(find-file :wk "Find file")
    "M-u" '(universal-argument :wk "Universal argument"))

  (gmo/leader-keys
    "E"  '(:ignore t :wk "Emacs")
    "Er" '((lambda () (interactive) (load-file user-init-file)) :wk "Reload Emacs"))

  (gmo/leader-keys
    "h"  '(:ignore t :wk "Help")
    "hv" '(describe-variable :wk "Describe variable")
    "hf" '(describe-function :wk "Describe function")
    "ht" '(consult-theme :wk "Load theme"))

  (gmo/leader-keys
    "b"  '(:ignore t :wk "Buffer")
    "bi" '(consult-buffer :wk "Ibuffer")
    "bk" '(kill-this-buffer :wk "Kill buffer")
    "br" '(revert-buffer :wk "Reload buffer"))
  
  (gmo/leader-keys
    "w"  '(:ignore t :wk "Windows")
    "wc" '(evil-window-delete :wk "Close current windows")
    "ws" '(evil-window-split :wk "Horizontal split")
    "wv" '(evil-window-vsplit :wk "Vertical split")
    "wh" '(evil-window-left :wk "Window left")
    "wj" '(evil-window-down :wk "Window down")
    "wk" '(evil-window-up :wk "Window up")
    "wl" '(evil-window-right :wk "Window right")
    "ww" '(evil-window-next :wk "Window next"))

  (gmo/leader-keys
    "p"  '(:ignore t :wk "Project")
    "pf" '(consult-fd :wk "Project file")
    "ps" '(consult-ripgrep :wk "Project search")
    "pg" '(consult-git-grep :wk "Project git search")
    "pi" '(consult-imenu :wk "Project imenu search")
    "pl" '(consult-line :wk "project line search"))

  (gmo/leader-keys
    "d"  '(:ignore t :wk "Dired")
    "dd" '(dired :wk "Open Dired")
    "dn" '(:ignore t :wk "Neotree")
    "dno" '(neotree-dir :wk "Open neotree")
    "dnh" '(neotree-hide :wk "Hide neotree"))

  (gmo/leader-keys
    "l" '(:ignore t :which-key "Lsp")
    "ld" 'xref-find-definitions
    "lr" 'xref-find-references
    "ln" 'lsp-ui-find-next-reference
    "lp" 'lsp-ui-find-prev-reference
    "le" 'lsp-ui-flycheck-list
    "lS" 'lsp-ui-sideline-mode
    "lX" 'lsp-execute-code-action)

  (gmo/leader-keys
    "f"  '(:ignore t :wk "File")
    "fe" '(dired :wk "Dired")
    "fC" '((lambda() (interactive) (find-file "~/.emacs.d/Emacs.org")) :wk "Open emacs config folder (.org)")))

(provide 'gmo-keybinds)
