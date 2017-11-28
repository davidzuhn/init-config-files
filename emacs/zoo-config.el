;;;; an -*- emacs-lisp -*- file describing miscellaneous configuration
;;;; options for GNU emacs
;;;;

(setq make-backup-files t
      kept-old-versions 5
      kept-new-versions 20
      trim-versions-without-asking t)

;;; make sure that the final newline gets put into the file
(setq require-final-newline t)

;;; Info file: this depends on the local copy of info.el
;;; from: Dave Gillespie -- daveg@csvax.cs.caltech.edu
;;;
(require 'info)

;;; ignore files with these extension when doing filename completeion
(setq completion-ignored-extensions
      ' (".d" ".o" ".i" ".s" ".elc" "~" ".bin" ".lbin" ".fasl" ".dvi"
	 ".toc" ".log"  ".aux" ".lof" ".blg" ".bbl" ".glo" ".idx" ".lot"))

;;; enable several things that are usually disabled
(put 'eval-expression  'disabled nil)	; ESC-ESC
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page   'disabled nil)

;;; finally, some miscellaneous emacs configuration

(setq gc-cons-threshold 500000		; don't gc as often
      inhibit-gnu-project-ads t
      inhibit-startup-message t)	; I *know* there isn't any warranty

;;; set up my mode line to display the current date and time
(setq display-time-day-and-date t)
(setq default-mode-line-format
      (list
       ""
       mode-line-modified
       " %25b "		                ; buffer name, field width 12
       "   %[("				; recursive edit levels
       'mode-name
       'minor-mode-alist
       "%n"				; prints Narrow when in effect
       'mode-line-process		
       ")%]--"
       '(-3 . "%p")			; percent of buffer
       "-%-"))				; fill to end with -


(autoload 'mwheel-install "mwheel" "Enable mouse wheel support.")
(mwheel-install)



