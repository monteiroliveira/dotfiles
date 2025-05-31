;; lisp/+magit.el --- Magit -*- lexical-binding: t; -*-

(straight/require 'magit)
(global-set-key (kbd "C-c m w m") 'magit-worktree-move)

(global-set-key (kbd "C-x m") 'magit) ;; need to look more of this.
(global-set-key (kbd "C-c m l") 'magit-log)
(global-set-key (kbd "C-c m s") 'magit-status)

(defun magitc/gather-avaliables-worktrees ()
  "Stoled from https://github.com/magit/magit/blob/main/lisp/magit-worktree.el
magit-worktree-status, but this just collect the available worktrees to use in
the next functions"
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
If the file exit so open the file with 'find-file' else open 'dired'"
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

(global-set-key (kbd "C-c m w m") 'magit-worktree-move)
(global-set-key (kbd "C-c m w b") 'magit-worktree-branch)
(global-set-key (kbd "C-c m w c") 'magit-worktree-checkout)
(global-set-key (kbd "C-c m w g") 'magitc/magit-goto-worktree)
(global-set-key (kbd "C-c m w G") 'magitc/magit-goto-worktree-file)

(provide '+magit)
