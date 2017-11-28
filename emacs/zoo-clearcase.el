(setq view-name (getenv "CLEARCASE_ROOT"))
(if view-name
    (setq frame-title-format (concat view-name ":    %b"))
  (setq frame-title-format "XEmacs: %b"))
