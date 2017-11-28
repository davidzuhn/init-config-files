;;;; an -*- emacs-lisp -*- startup file for GNU emacs

;;; set up the load path -- the default is set in the emacs source
;;; file .../src/paths.h, and possibly modified in .../lisp/default.el

(if (not (boundp 'original-load-path))
    (setq original-load-path load-path))

(setq my-load-paths (list
		     (expand-file-name "~/lib/emacs")
		     ))

(setq load-path (append my-load-paths original-load-path ))

(setq debug-on-error t)


(load-library "zoo-display")

;;;; load various useful functions
(load-library "zoo-functions")

;;;; various other configuration options
(load-library "zoo-config")

;;;; configure major and minor modes (autoloads, auto-mode-alist,
;;;; configuration parameters, etc)
(load-library "zoo-modes")

;;;; XEmacs specific code
;(load-library "zoo-xemacs")

;(load-library "zoo-aquamacs")

;;;; configure third-party packages that I used all of the time
(load-library "zoo-packages")

;;;; set all keybindings
(load-library "zoo-keybindings")

(setq debug-on-error nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 2))



(setq debug-on-error nil)
