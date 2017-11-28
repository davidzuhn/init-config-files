;;;; an -*- emacs-lisp -*- file where all personal keybindings are done
;;;;

;;; personal keybindings -- all should be set here, not anywhere else
;;; in the file

;; make this available for private key bindings....
(setq zoo-key-bindings
      '(
        ("\C-x\C-q" . toggle-read-only)
	("\C-r"     . isearch-backward)
	("\e\C-r"   . isearch-backward-regexp)
	("\C-c\C-w" . zoo-c-wrap-ifdef)
	("\C-x\C-b" . zoo-buffer-menu)
	("\C-x\C-c" . zoo-exit-from-emacs)
	("\C-ca"    . add-change-log-entry)
	("\C-cp"    . zoo-perl-comment-block)
	("\C-c\C-p" . cperl-perldoc)
	("\C-cb"    . bury-buffer)
	("\C-cd"    . insert-date-at-point)
	("\C-cl"    . goto-line)
	("\C-cm"    . compile)
	("\C-cw"    . what-line)
	("\C-cs"    . zoo-remove-trailing-ws)
	("\C-z"     . shell)
	("\M-z"     . zap-up-to-char)
	))

(global-unset-key "\C-xf")

; Define misc keys.
(mapcar (function (lambda (binding)
                    (global-set-key (car binding) (cdr binding))))
	zoo-key-bindings)


(defun zoo-isearch-mode-fn ()
  "set up isearch minor modes right"
  (define-key isearch-mode-map "\C-j" 'isearch-exit)
  (define-key isearch-mode-map "\C-m" 'isearch-exit))

(setq isearch-mode-hook 'zoo-isearch-mode-fn)
