;; lisp/builtin/telescope.el --- Find, Pick and other shit -*- lexical-binding: t; -*-

;; Telescope to emacs made by a dummy
;; REFERENCES: https://github.com/nvim-telescope/telescope.nvim/tree/master
;; OBS: Thinking in another name...
;; OUTDATED (using project.el)

;; Just can find a files in a git repo for now, i dont find any solution to
;; gather the default path when emacs start.

(defvar startup-working-directory default-directory) ;; not the better solution but works

(defun telescope/completing-read
    (prompt choices &optional predicate require-match initial-input hist def)
  "Telescope works just with ido (because i only use ido)"
  (if (and (require 'ido-completing-read+ nil t)
           (fboundp 'ido-completing-read+))
      (ido-completing-read+ prompt choices predicate
                            require-match initial-input hist
                            (or def (and require-match (car choices))))
    (display-warnineg 'telescope "ido-completing-read+ is not installed")))

(defun telescope/gather-git-files-in-path (&optional dir)
  "Search the files to look to a .git and go up in the directory tree
return nil if not found"
  (when (equal dir nil)
    (setq dir default-directory))
  (let ((parent (file-name-directory (directory-file-name dir))))
    (cond
     ((file-exists-p (expand-file-name ".git" dir)) dir)
     ((file-exists-p (expand-file-name "HEAD" dir)) dir) ;; Check if is a bare checkout
     ((or (not parent) (equal dir parent)) nil)
     (t (telescope/gather-git-files-in-path parent)))))

(defun telescope/live-grep-git (file)
  "List the files in the git root dir and 'find-file' the choosed file"
  (interactive
   (list (telescope/completing-read
          "Files Git?> "
          (if-let ((root (telescope/gather-git-files-in-path)))
              (split-string
               (shell-command-to-string
                (format "find %s -type f" root)))
            (message ".git not found")))))
  (find-file file))

(defun telescope/live-grep (file)
  (interactive
   (list (telescope/completing-read
          "Files?> "
          (if-let ((root startup-working-directory))
              (split-string
               (shell-command-to-string
                (format "find %s -type f" root)))))))
  (find-file file))

(provide 'telescope)
