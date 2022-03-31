;;; gap-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "gap-mode" "gap-mode.el" (0 0 0 0))
;;; Generated autoloads from gap-mode.el

(autoload 'gap-mode "gap-mode" "\
Major mode for writing GAP programs.  The following keys are defined:

\\{gap-mode-map}

Important variables: (with default given)

  `gap-indent-step' = (default 4)
        the amount of indentation to add at each level of a group

  `gap-indent-step-continued' =  (default 2)
        the extra indentation for continued lines that aren't special
        in some way.

See also the documentation for the variables:
  `gap-pre-return-indent'
  `gap-post-return-indent'
  `gap-indent-comments'
  `gap-indent-comments-flushleft'
  `gap-auto-indent-comments'
  `gap-indent-brackets'
  `gap-bracket-threshold'
  `gap-tab-stop-list'
  `gap-mode-hook'

and documentation for the functions:
  `gap-percent-command'

The indentation style is demonstrated by the following example,
assuming default indentation variables:

test := function (x,y)
    # this is a test
    local n,
          m,
          x;
    if true then
        Print( \"if true then \",
               \"nothing\");
    fi;
    x := [ [ 1, 2, 3 ],
           [ 5, 6, 8 ],
           [ 9, 8, 7 ] ];
    y := 1 + 2 + 3 +
         4 + 5 + 6;
    z := Filtered( List( origlist,
               x -> f( x + x^2 + x^3 + x^4 + x^5,
                       x^-1, x^-2, x^-3)),
               IsMat);
end;

\(fn)" t nil)

(add-to-list 'auto-mode-alist (cons (concat "\\." (regexp-opt '("gap" "g" "gd" "gi") t) "\\'") 'gap-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "gap-mode" '("gin-retain-indent-re" "gap-" "memberequal" "lines-indentation" "beg-of-line-from-point" "end-of-line-from-point" "to-tab-stop")))

;;;***

;;;### (autoloads nil "gap-process" "gap-process.el" (0 0 0 0))
;;; Generated autoloads from gap-process.el

(autoload 'gap "gap-process" "\
Start or switch to a GAP session.
If SEND-BUFFER is non-nil, send the contents of the current
buffer to the GAP session as initial standard input.

\(fn &optional SEND-BUFFER)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "gap-process" '("buttonize-syntax-error" "get-start-process" "gap-" "string-strip-chars" "scrolling-process-filter" "ensure-gap-running")))

;;;***

;;;### (autoloads nil "gap-smie" "gap-smie.el" (0 0 0 0))
;;; Generated autoloads from gap-smie.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "gap-smie" '("gap-smie-")))

;;;***

;;;### (autoloads nil nil ("gap-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; gap-mode-autoloads.el ends here
