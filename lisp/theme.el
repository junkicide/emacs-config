(provide 'theme)

(load-theme 'sanityinc-tomorrow-eighties t)

(custom-set-variables
 '(custom-safe-themes
   '("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
(custom-set-faces)

(custom-set-faces '(default
    ((t (:family "Pragmata Pro" :slant normal :weight normal :height 140 :width normal) ))))

(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-set-footer nil)
