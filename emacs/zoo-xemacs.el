(setq zmacs-regions nil)

(global-set-key 'backspace 'delete-backward-char)

(if (string= (getenv "USER") "root")
    (setq frame-title-format "ROOT: %b")
  (setq frame-title-format "%b"))

(setq menubar-show-keybindings nil)

