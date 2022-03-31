(require 'package)
(require 'use-package)


;;GENERAL SETTINGS


(setenv "HOME" "/home/akulkarni/")

;; Display battery for when in full screen mode
(display-battery-mode t)

;; no scroll-bar
(toggle-scroll-bar -1)

;; preserve cursor position while scrolling
(setq scroll-preserve-screen-position 'always)

;;disable splash screen and startup message
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)


;;load material theme
(add-hook 'after-init-hook (lambda () (load-theme 'material)))




;;ensure org mode
(use-package org
  :ensure t)

(use-package beacon ;; This applies a beacon effect to the highlighted line
   :ensure t
   :config
   (beacon-mode 1))




;; erc stuff
(setq
 erc-nick "junkicide"     ; Our IRC nick
) ; Our /whois name


;;helm stuff
(use-package helm
  :init
    (require 'helm-config)
    (setq helm-split-window-in-side-p t
          helm-move-to-line-cycle-in-source t)
  :config 
    (helm-mode 1) ;; Most of Emacs prompts become helm-enabled
    (helm-autoresize-mode 1) ;; Helm resizes according to the number of candidates
    (global-set-key (kbd "C-x b") 'helm-buffers-list) ;; List buffers
    (global-set-key (kbd "C-x r b") 'helm-bookmarks) ;; Bookmarks menu
    (global-set-key (kbd "C-x C-f") 'helm-find-files) ;; Finding files with Helm
    (global-set-key (kbd "M-c") 'helm-calcul-expression) ;; Use Helm for calculations
    (global-set-key (kbd "C-s") 'helm-occur)  ;; Replaces the default isearch keybinding
    (global-set-key (kbd "C-h a") 'helm-apropos)  ;; Helmized apropos interface
    (global-set-key (kbd "M-x") 'helm-M-x)  ;; Improved M-x menu
    (global-set-key (kbd "M-y") 'helm-show-kill-ring)  ;; Show kill ring, pick something to paste
  :ensure t)







(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   (vector "#ffffff" "#f36c60" "#8bc34a" "#fff59d" "#4dd0e1" "#b39ddb" "#81d4fa" "#263238"))
 '(auto-complete-mode t t)
 '(column-number-mode t)
 '(company-ghc-show-info t)
 '(company-selection-wrap-around t)
 '(completion-auto-help t)
 '(completion-cycle-threshold t)
 '(custom-enabled-themes '(adwaita))
 '(custom-safe-themes
   '("7922b14d8971cce37ddb5e487dbc18da5444c47f766178e5a4e72f90437c0711" "89885317e7136d4e86fb842605d47d8329320f0326b62efa236e63ed4be23c58" default))
 '(desktop-save-mode t)
 '(display-line-numbers-type nil)
 '(fci-rule-color "#37474f")
 '(global-hl-line-mode t)
 '(haskell-mode-hook
   '(flyspell-prog-mode haskell-decl-scan-mode haskell-indent-mode haskell-indentation-mode highlight-uses-mode interactive-haskell-mode company-mode linum-mode lsp enable-paredit-mode))
 '(helm-autoresize-mode t)
 '(helm-candidate-number-limit 5)
 '(helm-completion-style 'helm)
 '(helm-display-buffer-default-height 20)
 '(helm-mode 1)
 '(helm-move-to-line-cycle-in-source t)
 '(hl-sexp-background-color "#1c1f26")
 '(lsp-auto-configure t)
 '(lsp-haskell-liquid-on t)
 '(lsp-haskell-server-path
   "/nix/store/1jcpknb79lqckq8kxbh1adslk59ldqqz-haskell-language-server-exe-haskell-language-server-1.2.0.0/bin/haskell-language-server")
 '(menu-bar-mode nil)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(projectile magit impatient-mode flycheck-rust company rustic company-auctex auctex slime-company beacon use-package helm-core helm vterm lsp-haskell lsp-ui lsp-mode material-theme git ac-slime auto-complete company-anaconda company-cabal company-ghci agda2-mode aggressive-indent multiple-cursors ghci-completion pdf-tools slime quelpa paredit melpa-upstream-visit erlatex-unicode-math-mode haskell-mode gap-mode bash-completion))
 '(read-file-name-completion-ignore-case t)
 '(set-face-foreground 'highlight)
 '(show-paren-mode t)
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25)
 '(tool-bar-mode nil)
 '(user-mail-address "ajinkya@heliax.dev")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a")))
 '(vc-annotate-very-old-color nil))
(package-initialize)

 

(defvar electrify-return-match
  "[\]}\)\"]"
  "If this regexp matches the text after the cursor, do an \"electric\" return.")

(defun electrify-return-if-match (arg)
    "If the text after the cursor matches `electrify-return-match' then
  open and indent an empty line between the cursor and the text.  Move the
  cursor to the new line."
    (interactive "P")
    (let ((case-fold-search nil))
      (if (looking-at electrify-return-match)
	  (save-excursion (newline-and-indent)))
      (newline arg)
      (indent-according-to-mode)))
  ;; Using local-set-key in a mode-hook is a better idea.
  (global-set-key (kbd "RET") 'electrify-return-if-match)


;; slime stuff
(load (expand-file-name "~/quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "/usr/local/bin/sbcl")


(slime-setup '(slime-fancy
	       slime-company
               slime-autodoc
               slime-indentation))

(setq slime-net-coding-system 'utf-8-unix
      slime-truncate-lines nil)

(setq lisp-lambda-list-keyword-parameter-alignment t
      lisp-lambda-list-keyword-alignment t)
       (setq show-paren-delay 0)
      (show-paren-mode 1)
      
    (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
    (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
    (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
    (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
    (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
    (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
    (add-hook 'scheme-mode-hook           #'enable-paredit-mode)
    (add-hook 'LaTeX-mode-hook #'visual-line-mode)  
    (add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
    ;; Stop SLIME's REPL from grabbing DEL,
          ;; which is annoying when backspacing over a '('
          (defun override-slime-repl-bindings-with-paredit ()
            (define-key slime-repl-mode-map
                (read-kbd-macro paredit-backward-delete-key) nil))
          (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)    
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
 (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
 (eval-after-load "auto-complete"
   '(add-to-list 'ac-modes 'slime-repl-mode))          

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fantasque Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 100 :width normal))))
 '(hl-line ((t nil))))


;;HASKELL
;;(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
;;  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
;;  (add-to-list 'exec-path my-cabal-path))
;;

;;(require 'haskell-mode)
;; ghc-mod
;;(autoload 'ghc-init "ghc" nil t)
;;(autoload 'ghc-debug "ghc" nil t)
;;(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
;;(add-hook 'haskell-mode-hook #'hindent-mode)
;;(setq haskell-process-type 'cabal-repl)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'linum-mode)
;;(add-to-list 'exec-path "~/.local/bin")
;;(eval-after-load 'haskell-mode
;;          '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))
;;(eval-after-load 'haskell-mode '(progn
;;  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
;;    (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;;  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
;;  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
;;  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
;;  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
;;  (define-key haskell-mode-map "\C-ch" 'haskell-hoogle)
;;  (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def)
;;(eval-after-load 'haskell-cabal '(progn
;;    (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;;  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-ode-clear)
;;  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;;  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal) ))
;;
;;(require 'company-ghci)
;;(push 'company-ghci company-backends)
;;(add-hook 'haskell-mode-hook 'company-mode)
;;;;; To get completions in the REPL
;;(add-hook 'haskell-interactive-mode-hook 'company-mode)
;;;; haskell language server
;;(add-hook 'haskell-literate-mode-hook #'lsp)


;; TLA+ mode
(load "~/.emacs.d/tla-tools/tla+-mode.el")
(require 'tla+-mode)
(setq tla+-tlatools-path "/opt/TLA+Toolbox/tla2tools.jar") 
(setq auto-mode-alist
  (append
   ;; File name (within directory) starts with a dot.
   '(
     ;; File name ends in ‘.C’.
     ("\\.tla\\'" . tla+-mode))
   auto-mode-alist))

;;;; ivy mode
;;(add-to-list 'load-path "~/.emacs.d/ivy/")
;;(add-to-list 'auto-mode-alist '("\\.ivy\\'" . ivy-mode))
;;(autoload 'ivy-mode  "ivy-mode.el" "Major mode for editing Ivy code" t nil)

;; LateX stuff
(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; fullscreen mode
(defun fullscreen ()
       (interactive)
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                 '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
(fullscreen)

;display buffer list in the same window
 (global-set-key (kbd "C-x C-b") 'buffer-menu)

