;; org.el
;;   Configure org-mode key bindings and custom functions
;;
;; This module depends on org mode.
;;
;;
;; This file is part of LIBKOOKIE, a collection of nix expressions.
;; LIBKOOKIE is licensed under the GPL-3.0 (or later) -- see LICENSE

(provide 'init-org)

;;; Setup org-roam basics
(require 'org)
(require 'ox-reveal)
(load-library "ox-reveal")

;;; Setup org-roam mode
(setq org-roam-v2-ack t)
(require 'org-roam)
(require 'org-roam-ui)


;;; Set .org as my file ending of choice
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(defun org-open-at-point-in-current-window ()
  "A utility function to easily navigate org-mode file trees"
  (interactive)
  (let ((org-link-frame-setup (quote
                               ((vm . vm-visit-folder)
                                (vm-imap . vm-visit-imap-folder)
                                (gnus . gnus)
                                (file . find-file)
                                (wl . wl)))
                              ))
    (org-open-at-point)))

(defun org-insert-source-block ()
  "Insert a source code block"
  (interactive)
  (insert (concat "#+BEGIN_SRC " (read-string "Enter the source language: ")))
  (insert "\n\n#+END_SRC") (indent-according-to-mode)
  (previous-line 1) (indent-according-to-mode))

(defun org-insert-block ()
  "Insert a generic code block"
  (interactive)
  (setq org-insert-block-type (upcase (read-string "Enter block type: ")))
  (insert (concat "#+BEGIN_" org-insert-block-type))
  (insert (concat "\n\n#+BEGIN_" org-insert-block-type))
  (indent-according-to-mode)
  (previous-line 1)
  (indent-according-to-mode))

;;; Setup org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (dot . t)))

(defun kookie/fix-inline-images ()
  (when org-inline-image-overlays
    (org-redisplay-inline-images)))

(add-hook 'org-babel-after-execute-hook 'kookie/fix-inline-images)

;;; Org mode key bindings replicated here to make it easier for me
(define-key org-mode-map "\C-c\C-o" 'org-open-at-point-in-current-window)
(define-key org-mode-map "\C-S-<up>" nil)
(define-key org-mode-map "\C-S-<down>" nil)
