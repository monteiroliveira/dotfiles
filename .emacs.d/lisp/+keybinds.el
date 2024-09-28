;;; lisp/+keybinds.el --- General Emacs keybinds -*- lexical-binding: t; -*-

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
    "hf" '(describe-function :wk "Describe function"))

  (gmo/leader-keys
    "b"  '(:ignore t :wk "Buffer")
    "bk" '(kill-this-buffer :wk "Kill buffer")
    "br" '(revert-buffer :wk "Reload buffer"))
  
  (gmo/leader-keys
    "d"  '(:ignore t :wk "Dired")
    "dd" '(dired :wk "Open Dired"))

  (gmo/leader-keys
    "l"  '(:ignore t :which-key "Lsp")
    "ld" '(xref-find-definitions :wk "Go to definition")
    "lr" '(xref-find-references :wk "Go to reference")))

(provide '+keybinds)
