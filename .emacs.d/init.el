(setq inhibit-startup-message t) ; Disable startup menssage

(scroll-bar-mode -1)             ; Disable scroll bar
(tool-bar-mode -1)               ; Disable tool bar
(tooltip-mode -1)                ; Disable tooltips
(menu-bar-mode -1)               ; Disable menubar
(set-fringe-mode 20)

;; Active line numbers
(global-linum-mode t)

(global-prettify-symbols-mode t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Stop make backup files
(setq make-backup-files nil)

(require 'vterm)
(dolist (mode '(org-mode-hook
                vterm-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (linum-mode 0))))

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

(set-face-attribute 'font-lock-comment-face nil ; Set comments to italic
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-function-name-face nil
                    :slant 'italic)

;;ZoomIn and ZoomOut
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t))

(use-package all-the-icons)
(use-package all-the-icons-dired)

(use-package rainbow-delimiters
  :hook ((pog-mode eldoc-mode) . rainbow-delimiters-mode))

(use-package beacon
  :init
  (beacon-mode))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  :config
  (evil-global-set-key 'normal (kbd "TAB") 'evil-indent-line)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  :config
  (evil-collection-init))

(use-package diminish)

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

(use-package which-key
  :init
  (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package smex
  :init
  (smex-initialize))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package dashboard
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  (setq dashboard-startup-banner 'logo)
  ;(setq dashboard-startup-banner "~/.emacs.d/images/alpaca300x300.png")  ;; use custom image as banner
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  (setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
  (setq dashboard-center-content nil)
  (setq dashboard-items '((recents   . 7)
			  (agenda    . 5)
			  (bookmarks . 5)
			  (projects  . 5)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
				    (bookmarks . "book"))))

(use-package general
  :config
  (general-evil-setup t)
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
    "bs" '(save-buffer :which-key "Save buffer")

    ;; Org
    "o"  '(:ignore t :which-key "Org")
    "ot" '(org-babel-tangle :which-key "Org Babel Tangle")
    "oe" '(org-export-dispatch :which-key "Org Export Dispatch")

    ;; File
    "f"  '(:ignore t :which-key "File")
    "fw" '(write-file :which-key "Write file")

    ;; Emacs
    "e"  '(:ignore t :which-key "Emacs")
    "er" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")
    "eq" '(save-buffers-kill-emacs :which-key "Save buffer and quit emacs")
    "eQ" '(kill-emacs :which-key "Quit emacs")))

(use-package flycheck
  :defer t
  :hook (lsp-mode . flycheck-mode))

(require 'ispell)
(setq ispell-dictionary "pt_BR")
(setq ispell-program-name "/usr/bin/aspell")

(use-package company
  :diminish
  :after lsp-mode
  :hook ((lsp-mode prog-mode org-mode) . company-mode)
  :custom
  (company-minimum-prefix-lenght 1)
  (company-idle-delay 0.0))

(use-package company-box
  :diminish
  :hook (company-mode . company-box-mode))

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

(defun alpamacs/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1)
  (diminish org-indent-mode))

(use-package org
  :hook (org-mode . alpamacs/org-mode-setup)
  :config
  (setq org-ellipsis " ▼")
  (setq org-hide-emphasis-markers t)
  (setq org-latex-pdf-process
        '("pdflatex -interaction nonstopmode -output-directory %o %f"
          "bibtex %b"
          "pdflatex -interaction nonstopmode -output-directory %o %f"
          "pdflatex -interaction nonstopmode -output-directory %o %f"))
  (alpamacs/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "●" "○" "◆" "●" "○" "◆")))

(use-package org-ref)

(use-package org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode))

(use-package toc-org
  :hook (org-mode . toc-org-enable))

(use-package evil-org
  :after org
  :hook (org-mode . evil-org-mode))

(defun alpamacs/org-visual-fill ()
  (setq visual-fill-column-width 150
	visual-fill-column-center-text t)
  (visual-fill-column-mode))

  (use-package visual-fill-column
    :defer t
    :hook (org-mode . alpamacs/org-visual-fill))

(use-package yasnippet
  :config
  (yas-global-mode))

(use-package doom-snippets
  :after yasnippet
  :straight (doom-snippets :type git :host github :repo "doomemacs/snippets" :files ("*.el" "*")))

(use-package rust-mode)

(use-package haskell-mode)
(use-package lsp-haskell)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((haskell-mode c-mode cc-mode rust-mode) . lsp)
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-lens-enable nil))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy)))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands (magit-status magit-get-current-branch))

(use-package vterm
  :init (setq shell-file-name "/bin/fish"
              vterm-max-scrollback 5000))

(defun alpamacs/set-frame-opacity (opacity)
  (interactive
   (list (read-number "Opacity (0-100): "
                      (or (frame-parameter nil 'alpha)
                          100))))
  (set-frame-parameter nil 'alpha opacity))
