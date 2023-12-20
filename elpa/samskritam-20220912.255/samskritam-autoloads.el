;;; samskritam-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "samskritam" "samskritam.el" (0 0 0 0))
;;; Generated autoloads from samskritam.el

(autoload 'samskritam-word "samskritam" "\
Define WORD by referencing various dictionary SERVICE.
By default uses `samskritam-word-default-service', but a prefix arg
lets the user CHOOSE-SERVICE.

\(fn WORD SERVICE &optional CHOOSE-SERVICE)" t nil)

(autoload 'samskritam-word-at-point "samskritam" "\
Use `samskritam-word' to define word at point.
When the region is active, define the marked phrase.
Prefix ARG lets you choose service.

In a non-interactive call SERVICE can be passed.

\(fn ARG &optional SERVICE)" t nil)

(defvar samskritam-mode nil "\
Non-nil if Samskritam mode is enabled.
See the `samskritam-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `samskritam-mode'.")

(custom-autoload 'samskritam-mode "samskritam" nil)

(autoload 'samskritam-mode "samskritam" "\
Toggle Samskritam mode.

This is a minor mode.  If called interactively, toggle the
`Samskritam mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='samskritam-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "samskritam" '("samskritam-"))

;;;***

;;;### (autoloads nil nil ("samskritam-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; samskritam-autoloads.el ends here
