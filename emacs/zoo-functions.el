;;;; an -*- emacs-lisp -*- source file for GNU emacs initialization
;;;;

;; If a filename is "Makefile", change the buffer name to include the
;; parent directory so we don't get so many enumerated buffer names.
;;
(defun fix-makefile-names ()
  (if (eq (string-match "Makefile" (buffer-name)) 0)
      (rename-buffer (concat (file-name-nondirectory
                              (directory-file-name
                               (file-name-directory buffer-file-name)))
			     "/"
                             (buffer-name))
                     t)))
(add-hook 'find-file-hooks 'fix-makefile-names)


;;; this function is just like buffer-menu, except that the meanings of
;;; calling with and without an argument are reversed (without an argument
;;; means we show only files, with we show everything
;;;
(defun zoo-buffer-menu (arg)
  "Make a menu of buffers so you can save, delete or select them.
With argument, show all buffers, instead of just files.
Type ? after invocation to get help on commands available.
Type q immediately to make the buffer menu go away."
  (interactive "P")
  (if arg
      (list-buffers t)
    (list-buffers nil))
  (list-buffers (not arg))
  (pop-to-buffer "*Buffer List*")
  (forward-line 2)
  (message
   "Commands: d, s, x; 1, 2, m, u, q; delete; ~;  ? for help."))


;;; exit from emacs only with explicit confirmation

(defun zoo-exit-from-emacs ()
  "Make sure the user really wants to exit Emacs."
  (interactive)
  (if (yes-or-no-p "Are you sure you want to exit emacs ")
      (progn
	(and (get-buffer "*shell*") (kill-buffer "*shell*"))
	(save-buffers-kill-emacs))))


;;;;

(defun zoo-c-wrap-ifdef ()
  "Wrap the #define on the line containg point inside of an #ifndef/#endif pair"
  (interactive)
  (save-excursion
    (beginning-of-line)
    (if (looking-at "\\([ \\t]*#define \\)\\([A-Za-z0-9_]+\\)")
	(let ((macro-name (buffer-substring (match-beginning 2) (match-end 2))))
	  (beginning-of-line)
	  (insert "#ifndef " macro-name "\n")
	  (forward-line)
	  (beginning-of-line)
	  (insert "#endif /* " macro-name " */\n")))))

;;;;

(defun insert-date-at-point ()
  "Insert the current time and date at point."
  (interactive)
  (insert
   (current-time-string)
   " "
   (user-real-login-name)
   "@"
   (system-name)))

;;;

(defun zoo-current-time ()
  "Returns the current date in a list (month day year hour minute second)."
  (let* ((date (current-time-string))
         (garbage
          (string-match
;           "^\\([A-Z][a-z]*\\) *\\([A-Z][a-z]*\\) *\\([0-9]*\\) .* \\([0-9]*\\)$"
           "^\\([A-Z][a-z]*\\) *\\([A-Z][a-z]*\\) *\\([0-9]*\\) *\\([0-9]*\\):\\([0-9]*\\):\\([0-9]*\\) *19\\([0-9]*\\)$"
           date))
         (month
          (cdr (assoc
                (substring date (match-beginning 2) (match-end 2))
                '(("Jan" . 1) ("Feb" . 2) ("Mar" . 3) ("Apr" . 4)
                  ("May" . 5) ("Jun" . 6) ("Jul" . 7) ("Aug" . 8)
                  ("Sep" . 9) ("Oct" . 10) ("Nov" . 11) ("Dec" . 12)))))
         (day
          (string-to-int (substring date (match-beginning 3) (match-end 3))))
         (year
          (string-to-int (substring date (match-beginning 7) (match-end 7))))
	 (hour
          (string-to-int (substring date (match-beginning 4) (match-end 4))))
	 (minute
          (string-to-int (substring date (match-beginning 5) (match-end 5))))
	 (second
          (string-to-int (substring date (match-beginning 6) (match-end 6)))))
    (list month day year hour minute second)))

(defun insert-timestamp-string ()
  (interactive)
  (let ((time (zoo-current-time)))
    (insert
     (format "%2d%02d%02d%02d%02d"
	     (nth 0 time) (nth 1 time) (nth 2 time)
	     (nth 3 time) (nth 4 time)
	     ))))


(defun zoo-toggle-read-only (&optional arg)
  "Change whether this buffer is visiting its file read-only.
Also changes the mode to one appropriate for the file.  This function
is suitable for use in view-mode to begin editing a file.
With arg, set read-only iff arg is positive."
  (interactive "_P")
  (setq buffer-read-only
        (if (null arg)
            (not buffer-read-only)
            (> (prefix-numeric-value arg) 0)))
  (if buffer-read-only
      (view-mode)
    (normal-mode))
  ;; Force mode-line redisplay
  (set-buffer-modified-p (buffer-modified-p)))


(defun zoo-perl-comment-block (&optional arg)
  "Insert a perl header block."
  (interactive "*p")
  (push-mark)
  (beginning-of-line)
  (insert (make-string 72 ?#) ?\n "##" ?\n "## ")
  (pop-mark)
  )


(defun zoo-remove-trailing-ws (&optional arg)
  "Remove any trailing whitespace from the buffer."
  (interactive "*p")
  (push-mark)
  (goto-char (point-min))
  (while (re-search-forward "\\s +$" nil t)
    (replace-match "" nil nil)
    (message "Whitespace removed"))
  (pop-mark)
  )


