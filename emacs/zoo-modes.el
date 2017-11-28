;;;; an -*- emacs-lisp -*- file to configure major and minor modes for
;;;; GNU emacs

(load-library "cperl-mode")
(defalias 'perl-mode 'cperl-mode)

(require 'cc-mode)


;(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)

;;; Configure the auto mode selection to add several file regexps
;;; that aren't part of the default.  At the same time, I autoload the
;;; appropriate files.
;;;
(defun autoload-regexp (regexp mode filename comment)
  "Set up autoloads and auto-mode-alist for the given mode."
  (setq auto-mode-alist (cons (cons regexp mode) auto-mode-alist))
  (if (not (fboundp mode))
      (autoload mode filename comment t)))

(setq auto-mode-alist (cons '("\\.l$" . text-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.y$" . text-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("[Mm]akefile" . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("motd$" . motd-mode) auto-mode-alist))

(autoload-regexp "\\.tcl$\\|\\.exp$" 'tcl-mode "tcl-mode"
		 "Major mode for editing Tcl/Tk/Expect programs.")

(autoload-regexp "\\.xpm$" 'xpm-mode "xpm-mode"
		 "Major mode for editing XPM pixmaps.")

(autoload-regexp "\\.\\([pP][Llm]\\|al\\)$" 'cperl-mode "perl"
		 "Major mode for editing Perl programs.")

(autoload-regexp "\\.p$" 'pas-mode "pascal-mode"
		 "Major mode for editing Pascal code.")

(autoload-regexp "\\.pas$" 'pas-mode "pascal-mode"
		 "Major mode for editing Pascal code.")

(autoload-regexp "\\.(cc|cpp.h)$" 'c++-mode "c++-mode"
		 "Major mode for editing C++ code")

(autoload-regexp "\\.ino$" 'c++-mode "c++-mode"
		 "Major mode for editing Arduino C++ code")

(autoload-regexp "\\.C$" 'c++-mode "c++-mode"
		 "Major mode for editing C++ code")

(autoload-regexp "\\.hh$" 'c++-mode "c++-mode"
		 "Major mode for editing C++ code")

(autoload-regexp "\\.bib$" 'bibtex-mode "bibtex-mode"
		 "Major mode for editing BibTeX databases")

(autoload-regexp "\\.ps$" 'postscript-mode "postscript"
		 "Major mode for editing PostScript code")

(autoload-regexp "\\.gs$" 'ps-mode "ps"
		 "Major mode for editing GhostScript code")

(autoload-regexp "\\.texi$" 'texinfo-mode "texinfo"
		 "Major mode for editing TeXinfo documents")

;(autoload 'html-mode "html-mode" "HTML major mode." t)
;(or (assoc "\\.html$" auto-mode-alist)
;   (setq auto-mode-alist (cons '("\\.html$" . html-mode)
;                               auto-mode-alist)))

;(require 'html-mode)
(defun html-mode-hook ()
  (define-key html-mode-map "<" 'html-real-less-than)
  (define-key html-mode-map ">" 'html-real-greater-than)
  (define-key html-mode-map "&" 'html-ampersand)
  (define-key html-mode-map "\C-c<" 'html-less-than)
  (define-key html-mode-map "\C-c>" 'html-greater-than)
  (define-key html-mode-map "\C-c&" 'html-real-ampersand)
  )

(defun zoo-code-hookfn ()
  "Set various things I like in all code editing modes"
  "interactive"
  (abbrev-mode 1))

(add-hook 'before-save-hook     'delete-trailing-whitespace)

(add-hook 'c-mode-hook          'zoo-code-hookfn)
(add-hook 'emacs-lisp-mode-hook 'zoo-code-hookfn)
(add-hook 'c++-mode-hook        'zoo-code-hookfn)

(defun zoo-diff-hookfn ()
  "Set various things I like in all code editing modes"
  "interactive"
  (filladapt-mode -1))
(add-hook 'diff-mode-hook       'zoo-diff-hookfn)



;;; my text mode configuration

(defun zoo-text-mode-hook ()
  (abbrev-mode 1)
  (auto-fill-mode 1))

(setq default-major-mode 'text-mode)
(setq text-mode-hook     'zoo-text-mode-hook)

(setq-default fill-column 75
	      comment-column 50
	      goal-column nil)

(defvar makefile-mode-hook nil)
(defun makefile-mode ()
  "Major mode for editing makefiles"
  (interactive)
  (text-mode)
  (setq mode-name "Makefile")
  (setq major-mode 'makefile-mode)
  (setq comment-start "#")
  (run-hooks 'makefile-mode-hook))

(setq cperl-hairy t
      cperl-extra-newline-before-brace t
      cperl-pod-here-scan t
      cperl-electric-keywords nil
      cperl-electric-parens nil
      cperl-auto-newline nil
      )

(cperl-set-style "PerlStyle")

(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 8))

(setq-default c-basic-offset 2)

(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(setq auto-mode-alist (cons '(".*/linux.*/.*\\.[ch]$" . linux-c-mode)
                       auto-mode-alist))


;; Create my personal style.
(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 4)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (substatement-open . 0)
                                   (case-label        . 4)
				   (comment-intro     . -4)
                                   (block-open        . 0)
                                   (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . t))
  "My C Programming Style")
(c-add-style "PERSONAL" my-c-style)


;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; set my personal style for the current buffer
  (c-set-style "PERSONAL")
  ;; other customizations
  (setq tab-width 8
        ;; this will make sure spaces are used instead of tabs
        indent-tabs-mode nil
	c-basic-offset 2)
  ;; we like auto-newline, but not hungry-delete
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
