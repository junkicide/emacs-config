;; move-lines.el
;;   Provide a mechanism to move line selections
;;
;; By default, moving lines up and down in a buffer is very annoying,
;; so this set of functions creates a way to do this, and binds it to
;; easily accessible key bindings.  This mirrors functionality from
;; other GUI text editors such as sublime text or vs code.
;;
;;
;; This file is part of LIBKOOKIE, a collection of nix expressions.
;; LIBKOOKIE is licensed under the GPL-3.0 (or later) -- see LICENSE

(provide 'move-lines)

(defun move--section (offset)
  "Move a line or reg up or down by on offset."

  ;; We'll have to track 4 text points in this function
  ;; Future me: the * is important....
  (let* (txt-start
         txt-end
         (reg-start (point))
         (reg-end reg-start)

         ;; De we delete a trailing \n
         del-nl-trail)

    ;; Find the text borders
    (when (region-active-p)
      (if (> (point) (mark))
          (setq reg-start (mark))
        (exchange-point-and-mark)
        (setq reg-end (point))))
    (end-of-line)

    ;; If point > point-max there is no trailing \n
    (if (< (point) (point-max))
        (forward-char 1)
      (setq del-nl-trail t)
      (insert-char ?\n))
    (setq txt-end (point)
          reg-end (- reg-end txt-end))

    ;; text/region start points
    (goto-char reg-start)
    (beginning-of-line)
    (setq txt-start (point)
          reg-start (- reg-start txt-end))

    ;; Fake the txt move
    (let ((text (delete-and-extract-region txt-start txt-end)))
      (forward-line offset)
      (when (not (= (current-column) 0))
        (insert-char ?\n)
        (setq del-nl-trail t))
      (insert text))

    ;; Restore point position
    (forward-char reg-start)

    ;; Clean that annoying \n at the end
    (when del-nl-trail
      (save-excursion
        (goto-char (point-max))
        (delete-char -1)))

    ;; If we operated on a region we need to fix the selection
    (when (region-active-p)
      (setq deactivate-mark nil)
      (set-mark (+ (point) (- (- reg-start reg-end)))))))

(defun move-section-up (offset)
  "Move a line or reg upwards"
  (interactive "p")
  (if (eq offset nil)
    setq offset 1)
  (move--section (- offset)))

(defun move-section-down (offset)
  "Move a line or region dawnwards"
  (interactive "p")
  (if (eq offset nil)
      setq offset 1)
  (move--section offset))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Key bindings
;;;
;;; Custom set of key bindings to augment emacs' builtins

(global-set-key (kbd "C-M-<up>") 'move-section-up)
(global-set-key (kbd "C-M-<down>") 'move-section-down)
