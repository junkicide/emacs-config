;; multi-cursor.el
;;   Configure multiple-cursors mode with custom keybings
;;
;; This module depends on multiple-cursors mode.
;;
;;
;; This file is part of LIBKOOKIE, a collection of nix expressions.
;; LIBKOOKIE is licensed under the GPL-3.0 (or later) -- see LICENSE

(provide 'multi-cursor)
(require 'multiple-cursors)

;;; Multiple cursors bindings
(global-set-key (kbd "C-H-c C-H-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
