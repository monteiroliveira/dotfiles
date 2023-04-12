;; Disable interface stuffs
(setq inhibit-startup-message t) ; Disable startup menssage

(scroll-bar-mode -1) ; Disable scroll bar
(tool-bar-mode -1)   ; Disable tool bar
(tooltip-mode -1)    ; Disable tooltips
(menu-bar-mode -1)   ; Disable menubar
(set-fringe-mode 10)

;; Active line numbers
(global-linum-mode t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;ZoomIn and ZoomOut
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Stop make backup files
(setq make-backup-files nil)

;; FONT SETTINGS
(set-face-attribute 'default nil
		    :font "JetBrainsMono Nerd Font"
		    :height 110
		    :weight 'medium)

(set-face-attribute 'variable-pitch nil
		    :font "Ubuntu Nerd Font"
		    :height 115
		    :weight 'medium)

(set-face-attribute 'fixed-pitch nil
		    :font "JetBrainsMono Nerd Font"
		    :height 110
		    :weight 'medium)

(global-prettify-symbols-mode t)

;; PACKAGE MANAGER
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Installing use-package on non-linux plataforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; PACKAGES
;; Evil mode - It's essesial for me and my life
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Enable mode diminishing
(use-package diminish)

;; Ivy and counsel for completition
(use-package ivy
  :diminish ivy-mode
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (setq ivy-to-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-count-format "(%d/%d) ")
  (ivy-mode 1))

(use-package ivy-rich ;; Give keybinds with documentation
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x"     . counsel-M-x)
	 ("C-x b"   . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file))
  :config
  (setq ivy-initial-inputs-alist nil))

;; Which key
(use-package which-key
  :init
  (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Helpful, for a better documentation
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; THEMES AND APPEARANCE
(use-package all-the-icons)
(use-package all-the-icons-dired)

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-one t))

(set-face-attribute 'font-lock-comment-face nil ; Set comments to italic
		    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
		    :slant 'italic)
(set-face-attribute 'font-lock-function-name-face nil
		    :slant 'italic)

(use-package rainbow-delimiters
  :hook ((pog-mode eldoc-mode) . rainbow-delimiters-mode))

(use-package beacon
  :init
  (beacon-mode))

;; Dashboard
(use-package dashboard
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  (setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;(setq dashboard-startup-banner "~/.emacs.d/images/alpaca300x300.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents   . 5)
                          (agenda    . 5)
                          (bookmarks . 3)
                          (projects  . 3)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
				    (bookmarks . "book"))))

;; GERAL KEYBINDS
(use-package general
  :config
  (general-create-definer kbs/leader-key-def
    :states '(normal visual emacs)
    :prefix "SPC")

  (kbs/leader-key-def
    ;;Find
    "."  '(counsel-find-file :which-key "Find file")

    ;; Window
    "w"  '(:ignore t :which-key "Window")
    "wc" '(evil-window-delete :which-key "Delete current window")
    "wn" '(evil-window-new :which-key "New window")
    "ws" '(evil-window-split :which-key "Horizontal split window")
    "wv" '(evil-window-vsplit :which-key "Vertical split window")

    "wh" '(evil-window-left :which-key "Window left")
    "wj" '(evil-window-down :which-key "Window down")
    "wk" '(evil-window-up :which-key "Window up")
    "wl" '(evil-window-right :which-key "Window right")
    "ww" '(evil-window-next :which-key "Goto next window")

    ;; Buffers
    "b"  '(:ignore t :which-key "Buffer")
    "bi" '(ibuffer :which-key "Ibuffer")
    "bc" '(clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
    "bk" '(kill-current-buffer :which-key "Kill current buffer")
    "bn" '(next-buffer :which-key "Next buffer")
    "bp" '(previous-buffer :which-key "Previous buffer")
    "bB" '(ibuffer-list-buffers :which-key "Ibuffer list buffers")

    ;; Emacs
    "e"  '(:ignore t :which-key "Emacs")
    "er" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")))

;; ORG MODE
(defun alpamacs/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1)
  (diminish org-indent-mode))

(defun alpamacs/org-font-setup ()
    (dolist (face '((org-level-1 1.7 ultra-bold "#51afef")
		    (org-level-2 1.6 extra-bold "#c678dd")
		    (org-level-3 1.5 bold       "#98be65")
		    (org-level-4 1.4 semi-bold  "#da8548")
		    (org-level-5 1.3 normal     "#5699af")
		    (org-level-6 1.2 normal     "#a9a1e1")
		    (org-level-7 1.1 normal     "#46d9ff")
		    (org-level-8 1.0 normal     "#ff6c6b")))
      (set-face-attribute (car face) nil :font "Ubuntu Nerd Font" :weight (nth 2 face) :height (nth 1 face) :foreground (nth 3 face)))

  ;; Set fixed-pitch to some org-faces
  (set-face-attribute 'org-block    nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code     nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table    nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit '(shadow fixed-pitch)))

(use-package org
  :hook (org-mode . alpamacs/org-mode-setup)
  :config
  (setq org-ellipsis " ▼ ")
  (setq org-hide-emphasis-markers t)
  (alpamacs/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "●" "○" "◆" "●" "○" "◆")))

;; Auto-generate toc
(use-package toc-org
  :hook (org-mode . toc-org-enable))

;; PRODUCTIVITY
;; Flycheck, for spell check
(use-package flycheck
  :defer t
  :hook (lsp-mode . flycheck-mode))

;; Company for auto-completition
(use-package company
  :diminish company-mode
  :init
  (company-mode))

(use-package company-box
  :diminish company-box-mode
  :hook (company-mode . company-box-mode))

;; DEVELOPMENT
;; Languages
(use-package haskell-mode)
(use-package lsp-haskell)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((haskell-mode-hook . lsp)
	 (haskell-literate-mode-hook . lsp))
  :config
  (lsp-enable-which-key-integration t))

;; Projectile
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy)))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; Magit
(use-package magit
  :commands (magit-status magit-get-current-branch))

;; CUSTOM FUNCTIONS
;; Interactively change the current frame's opacity.
;; OPACITY is an integer between 0 to 100, inclusive."
(defun alpamacs/set-frame-opacity (opacity)
  (interactive
   (list (read-number "Opacity (0-100): "
                      (or (frame-parameter nil 'alpha)
                          100))))
  (set-frame-parameter nil 'alpha opacity))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lsp-haskell dashboard diminish company-box flycheck evil-magit magit counsel-projectile lsp-mode which-key use-package toc-org rainbow-delimiters org-bullets ivy-rich helpful general evil-collection doom-themes counsel all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
