(provide 'lisp)

;; defer lisp selection to ros
(setq inferior-lisp-program "ros -Q run")

;;; enable sly editing mode for lisp
(add-hook 'lisp-mode-hook 'sly-editing-mode)

;;; some annoying bug fix I don't remember now
(setq lispy-no-space t)

;;; enable lispy for sly editing
(add-hook 'sly-editing-mode-hook 'lispy-mode)
