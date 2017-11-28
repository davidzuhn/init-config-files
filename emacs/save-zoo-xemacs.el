

(require 'font-lock)
(add-hook 'font-lock-mode-hook 'turn-on-lazy-lock)

(require 'scroll-in-place)

(require 'rsz-minibuf)
(resize-minibuffer-mode)

(setq find-file-use-truenames nil
      find-file-compare-truenames t
      minibuffer-confirm-incomplete t
      complex-buffers-menu-p t
      next-line-add-newlines nil
      kill-whole-line t)

(setq mouse-yank-at-point t)

(setq auto-save-directory (expand-file-name "~/.autosave/")
      auto-save-directory-fallback auto-save-directory
      auto-save-hash-p nil
      ange-ftp-auto-save t
      ange-ftp-auto-save-remotely nil
      ;; now that we have auto-save-timeout, let's crank this up
      ;; for better interactive response.
      auto-save-interval 2000
      )
(require 'auto-save)

;(add-hook 'c-mode-hook (lambda () (setq c-basic-offset 2)))

(load-library "completer")

(setq crypt-encryption-type 'pgp   ; default encryption mechanism
      crypt-confirm-password t	   ; make sure new passwords are correct
      ;crypt-never-ever-decrypt t  ; if you don't encrypt anything, set this to
				   ; tell it not to assume that "binary" files
				   ; are encrypted and require a password.
      )
(require 'crypt)

(setq-default
  highlight-headers-follow-url-function 'highlight-headers-follow-url-netscape)

(global-set-key "\M- " 'set-mark-command)

(load-library "view-less")
(or (member 'auto-view-mode find-file-hooks)
    (setq find-file-hooks (cons 'auto-view-mode find-file-hooks)))

(defun exp-find-file (arg)
  (find-file (expand-file-name arg)))

(setq zmacs-regions nil)

(global-set-key 'backspace 'delete-backward-char)

(if (string= (getenv "USER") "root")
    (setq frame-title-format "ROOT: %b")
  (setq frame-title-format "%b"))

(setq menubar-show-keybindings nil)

(defun set-text-properties (start end props &optional buffer)
  "You should NEVER use this function.  It is ideologically blasphemous.
It is provided only to ease porting of broken FSF Emacs programs."
  (if (and (stringp buffer) (not (setq buffer (get-buffer buffer))))
      nil
    (map-extents #'(lambda (extent ignored)
		     (remove-text-properties start end
					     (list (extent-property extent
								    'text-prop)
						   nil)
					     buffer))
		 buffer start end nil nil 'text-prop)
    (add-text-properties start end props buffer)))

;(set-face-font 'default "-*-luxi mono-medium-r-normal-*-*-120-*-*-m-*-*-*")
;(set-face-font 'default "-*-lucidatypewriter-medium-*-*-*-*-140-*-*-m-*-*-*")

;(set-face-font 'default "-*-courier-medium-r-*-*-17-*-*-*-m-*-*-*")

(set-face-background 'default      "white")      ; frame background
(set-face-foreground 'default      "black")      ; normal text

(set-face-background 'zmacs-region "yellow")        ; When selecting w/ mouse
(set-face-foreground 'zmacs-region "black")

(set-face-background 'highlight    "blue")       ; Ie when selecting buffers
(set-face-foreground 'highlight    "yellow")

(set-face-background 'modeline     "gray91") ; Line at bottom of buffer
(set-face-foreground 'modeline     "gray20")
(set-face-font       'modeline     "-*-luxi mono-medium-r-normal-*-*-90-*-*-m-*-*-*")

(set-face-background 'isearch      "yellow") ; When highlighting while searching
(set-face-foreground 'isearch      "black")

(setq x-pointer-foreground-color   "black") ; Adds to bg color, so keep black
(setq x-pointer-background-color   "blue")  ; This is color you really
					    ; want ptr/crsr

(set-specifier menubar-visible-p t)
(set-specifier default-toolbar-visible-p nil)


