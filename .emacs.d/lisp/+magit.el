;; lisp/+magit.el --- Magit -*- lexical-binding: t; -*-

(straight/require 'magit)
(setq magit-completing-read-function 'magit-ido-completing-read)

(global-set-key (kbd "C-x m") 'magit) ;; need to look more of this.
(global-set-key (kbd "C-c m l") 'magit-log)
(global-set-key (kbd "C-c m s") 'magit-status)

(defun magitc/gather-avaliables-worktrees ()
  "Stoled from https://github.com/magit/magit/blob/main/lisp/magit-worktree.el
magit-worktree-status, but this just collect the available worktrees to use in
the next functions."
  (list (magit-completing-read
         "Worktrees"
         (cl-delete (directory-file-name (magit-toplevel))
                    (magit-list-worktrees)))))

(defun magitc/magit-goto-worktree (worktree)
  "Jump to another worktree and open 'dired'"
  (interactive (magitc/gather-avaliables-worktrees))
  (let ((repo-toplevel (magit-toplevel)))
    (if repo-toplevel
        (dired worktree))))

(defun magitc/magit-goto-worktree-file (worktree)
  "Jump to the current file in another worktree by relative path
If the file exit so open the file with 'find-file' else open 'dired'."
  (interactive (magitc/gather-avaliables-worktrees))
  (let ((buf-file-name buffer-file-name)
        (line-pos (line-number-at-pos))
        (current-buffer (current-buffer))
        (repo-toplevel (magit-toplevel)))
    (if (and worktree buf-file-name)
        (if (not (string= repo-toplevel worktree))
            (progn
              (let* ((relative-path (file-relative-name buf-file-name repo-toplevel))
                     (new-file (expand-file-name relative-path worktree)))
                (message relative-path)
                (if (file-exists-p new-file)
                    (progn
                      (find-file new-file)
                      (goto-line line-pos))
                  (dired (file-name-directory new-file)))))
          (switch-to-buffer current-buffer)))))

(defun magitc/add-raw-worktree (worktree)
  "Create a raw worktree and open 'dired' the work tree is create
in the bare repo root, OBS: this function works good only for my
workflow, feel free to change it if necessary."
  (interactive
   (magit-completing-read "Worktree Name" nil))
  (if-let ((repo-toplevel (magit-toplevel)))
      (progn
        (setq-local bare-root (file-name-directory repo-toplevel))
        (if (not (magit-toplevel))
            (setq-local bare-root repo-toplevel))
        (progn
          (shell-command
           (format
            "git worktree add %s"
            worktree))
          (dired bare-root)))
    (message "Not in a git repo")))

(global-set-key (kbd "C-c m w m") 'magit-worktree-move)
(global-set-key (kbd "C-c m w b") 'magit-worktree-branch)
(global-set-key (kbd "C-c m w c") 'magit-worktree-checkout)
(global-set-key (kbd "C-c m w d") 'magit-worktree-delete)
(global-set-key (kbd "C-c m w a") 'magitc/add-raw-worktree)
(global-set-key (kbd "C-c m w g") 'magitc/magit-goto-worktree)
(global-set-key (kbd "C-c m w G") 'magitc/magit-goto-worktree-file)

(provide '+magit)
