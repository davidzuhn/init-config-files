;;;; an -*- emacs-lisp -*- file to configure various external packages
;;;; used by my personal GNU emacs setup

;; C/C++ mode values
(setq c-basic-offset 2)

;;; add-log -- better ChangeLog entry support
;;; from: Sebastian Kremer -- sk@thp.uni-koeln.de
;(require 'add-log)

;;; ange-ftp -- remote file access via ftp
;;; from: Andy Norman -- ange@hplb.hpl.hp.com
;(require 'ange-ftp)

;;; dired -- directory edit.  This version has MUCH better support for
;;; subdirectories than the v18 code, as well as supporting ange-ftp.
;;; from: Sebastian Kremer -- sk@thp.uni-koeln.de
(require 'dired)
(setq dired-listing-switches "-FlG"
      dired-ls-F-marks-symlinks t
      dired-no-confirm '(revert-subdirs))

;;; filladapt -- word wrapping and filling, with paragraph indents
;;; handled correctly
;;; from: Kyle Jones -- kyle@uunet.uu.net
;(require 'filladapt)
;(setq-default filladapt-mode t)


(set-buffer-modified-p (buffer-modified-p))
(display-time)
