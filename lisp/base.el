;; base.el
;;   Configure emacs-builtins and core key bindings
;;
;; Emacs has a lot of things built-in that are disabled by default.
;; This module enables these settings, to create an editor experience
;; that I find more pleasing.  If you want to get a taste of what it
;; is to use "kookie emacs", start by including this file.
;;
;;
;; This file is part of LIBKOOKIE, a collection of nix expressions.
;; LIBKOOKIE is licensed under the GPL-3.0 (or later) -- see LICENSE

(provide 'base)

(direnv-mode)

;;; Setup consistent line numbering
(setq display-line-numbers-grow-only t)
(setq display-line-numbers-width-start t)
(global-display-line-numbers-mode t)

;;; Use spaces instead of tabs
(setq tab-width 2)
(setq-default indent-tabs-mode nil)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;;; Hide startup splash
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;;; Delete selections
(delete-selection-mode t)

;;; which key mode
(which-key-mode t)

;;; Change the swap/ autosave directory
(let ((backup-dir (concat user-emacs-directory "backups")))
  (make-directory backup-dir t)
  (setq backup-directory-alist (list (cons "." backup-dir)))
  (setq message-auto-save-directory backup-dir))

;;; Display and create symbol pairs
(show-paren-mode t)
(electric-pair-mode t)

;;; Rainbow delimiters mode
(rainbow-delimiters-mode t)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;; Don't soft-wrap lines
(setq-default truncate-lines t)

;;; Hide default UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;; Display column in the mode line
(column-number-mode t)

;;; Enable ido mode
;; (ido-mode t)
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)

;;; Enable vertico-mode completions
(vertico-mode t)
(vertico-multiform-mode t)
(setq vertico-multiform-commands
      '((consult-imenu unobtrusive)
        (execute-extended-command indexed)))
(keymap-set vertico-map "?" #'minibuffer-completion-help)
(keymap-set vertico-map "M-RET" #'minibuffer-force-complete-and-exit)
(keymap-set vertico-map "M-TAB" #'minibuffer-complete)
(keymap-set vertico-map "RET" #'vertico-directory-enter)

;;;marginalia
(marginalia-mode t)

;;; completions
(company-mode t)
(global-company-fuzzy-mode t)

;;; orderless
(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))

;;; Enable ruler-mode in all buffers
;;;(add-hook 'find-file-hook (lambda () (ruler-mode 1)))

;;; Setup mitosis buffer splitting
(defalias 'mitosis 'make-frame)

;;; Use the modeline from spacemacs
(require 'spaceline-config)
(spaceline-spacemacs-theme)
(spaceline-compile)
;;; OpenSCAD mode
(add-to-list 'auto-mode-alist '("\\.scad$" . scad-mode))

;;; Capn Proto mode
(add-to-list 'auto-mode-alist '("\\.capnp$" . protobuf-mode))

;;; Load centaur tabl and treemacs on new init
;; (require 'centaur-tabs)
(require 'treemacs)

;;; Setup projectile mode and bindings
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-project-search-path '("~/Projects/" "~/Documents/" ))


;;; epub reader
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function definitions
;;;
;;; A set of functions to compliment emacs' builtin functionality, to
;;; create and navigate buffers.

(defun new-empty-buffer ()
  "Opens a new empty buffer."
  (interactive)
  (let ((buf (generate-new-buffer "untitled")))
    (switch-to-buffer buf)
    (funcall (and initial-major-mode))
    (setq buffer-offer-save t)))

(defun user-buffer-q ()
  "Check if a buffer is a user buffer"
  (interactive)
  (if (string-equal "*" (substring (buffer-name) 0 1))
      nil
    (if (string-equal major-mode "dired-mode")
        nil
      t
      )))

(defun next-user-buffer ()
  "Switch to the next user buffer."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (user-buffer-q))
          (progn (next-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))

(defun previous-user-buffer ()
  "Switch to the previous user buffer."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (user-buffer-q))
          (progn (previous-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))

(defun fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
(fullscreen)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Key bindings
;;;
;;; Custom set of key bindings to augment emacs' builtins

(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "C-x n") 'new-empty-buffer)
(global-set-key (kbd "C-<next>") 'next-user-buffer)
(global-set-key (kbd "C-<prior>") 'previous-user-buffer)
(global-set-key (kbd "M-s M-s") 'save-buffer)
(global-set-key (kbd "C-t") 'smex)
(global-set-key (kbd "C-H-<left>") 'centaur-tabs-backward-tab)
(global-set-key (kbd "C-H-<right>") 'centaur-tabs-forward-tab)
(global-set-key (kbd "C-H-<up>") 'next-window-any-frame)
(global-set-key (kbd "C-H-<down>") 'previous-window-any-frame)