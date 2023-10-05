(setq default-directory "~/entropy/")

;; straight package manager (MELPA alternative)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package org)

;; org + latex
(use-package ox-extra
    :straight org-contrib
    :init
    :config
    (ox-extras-activate '(latex-header-blocks ignore-headlines)))

;;helm
(use-package helm-projectile
  :config (setq projectile-switch-project-action 'helm-projectile)
  )

(use-package helm
  :init
  (require 'helm-config)
  (setq helm-split-window-in-side-p t
        helm-move-to-line-cycle-in-source t)
  :config 
  (helm-mode 1) ;; Most of Emacs prompts become helm-enabled
  (helm-autoresize-mode 1) ;; Helm resizes according to the number of candidates
  (global-set-key (kbd "C-x b") 'helm-buffers-list)  ;; List buffers
  (global-set-key (kbd "C-x r b") 'helm-bookmarks)   ;; Bookmarks menu
  (global-set-key (kbd "C-x C-f") 'helm-find-files) ;; Finding files with Helm
  (global-set-key (kbd "M-c") 'helm-calcul-expression) ;; Use Helm for calculations
  (global-set-key (kbd "C-s") 'helm-occur) ;; Replaces the default isearch keybinding
  (global-set-key (kbd "C-h a") 'helm-apropos) ;; Helmized apropos interface
  (global-set-key (kbd "M-x") 'helm-M-x)       ;; Improved M-x menu
  (global-set-key (kbd "M-y") 'helm-show-kill-ring) ;; Show kill ring, pick something to past
  (require 'helm-projectile)
  (helm-projectile-on)
  )


(use-package helm-company)

(use-package undo-tree)
;; other tools


;; recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(use-package magit
  :init (if (not (boundp 'project-switch-commands)) 
	    (setq project-switch-commands nil)))
(use-package forge
  :after magit)

(use-package treemacs)

(use-package which-key
  :config (which-key-mode))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("M-." . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)



  :config

  ;; Show the Embark target at point via Eldoc.  You may adjust the Eldoc
  ;; strategy, if you want to see the documentation from multiple providers.
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)
  
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package flycheck)


;; mode-line utils

(use-package mood-line
  :config (mood-line-mode))
(use-package minions
  :config (minions-mode))

(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-eldoc-minibuffer-message-function))


(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))

(use-package sly-quicklisp)
(use-package sly
  :config
  (setq inferior-lisp-program "ros -Q run")
  (require 'sly-autoloads)
  (add-hook 'lisp-mode-hook 'sly-editing-mode)
  (add-hook 'emacs-lisp-mode-hook 'sly-editing-mode))

(use-package lispy
	     :config
             (setq lispy-no-space t)
	     (add-hook 'sly-editing-mode-hook 'lispy-mode)
	     (add-hook 'sly-mrepl-mode-hook 'lispy-mode))

;;rustic

(use-package rustic
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzers-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  ;; (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook)
  (add-hook 'rustic-mode-hook #'rustic-flycheck-setup)
 ;; collapse function definitions
(add-hook 'rustic-mode-hook 'hs-minor-mode) )

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t)))

;; lsp mode

(use-package lsp-mode
  :hook haskell-mode haskell-literate-mode rustic-mode
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-server 'rust-analyzer)
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil))

(use-package lsp-ui
  :commands lsp-ui-mode
  :hook lsp-mode
  :custom
  (lsp-ui-peek-always-show t)
  ;; (lsp-ui-sideline-show-hover nil)
  (lsp-ui-doc-show-with-cursor nil)
  (lsp-eldoc-enable-hover nil))

(use-package lsp-haskell)

;; code completions
(use-package company
  :custom
  (company-idle-delay 0.5)
  (company-show-numbers t)
  (company-selection-wrap-around t) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	("C-n". company-select-next)
	("C-p". company-select-previous)
	("M-<". company-select-first)
	("M->". company-select-last))
  :config (global-company-mode t))

;; (use-package company-tabnine
;;   :config (add-to-list 'company-backends #'company-tabnine))

;;code snippetsf0
(use-package yasnippet
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

;;inlay hints
(setq lsp-rust-analyzer-server-display-inlay-hints t)

;; rust cargo stuff
 (use-package cargo
      
        :config 
        ;; change emacs PATH o include cargo/bin
        (setenv "PATH" (concat (getenv "PATH") ":~/.cargo/bin"))
        (setq exec-path (append exec-path '("~/.cargo/bin"))))


(use-package parsec
  :straight (parsec
             :type git
             :host github
             :repo "cute-jumper/parsec.el"
             ))

  ;;(use-package evcxr
  ;;  :straight (evcxr
  ;;             :type git
  ;;             :host github
  ;;             :repo "serialdev/evcxr-mode")
  ;;  :config
  ;;  (add-hook 'rust-mode-hook #'evcxr-minor-mode)
;;  )
(use-package idris2-mode
  :straight (idris2-mode :type git :host github
                         :repo "idris-community/idris2-mode")
  :config (setq idris2-interpreter-path "/home/trinetra/.idris2/bin/idris2"))

(use-package agda2-mode
  :straight (agda2-mode :type git :host github
                        :repo "agda/agda"
                        :files ("src/data/emacs-mode/*.el"))
  :config (setq auto-mode-alist
                (append
                 '(("\\.agda\\'" . agda2-mode)
                   ("\\.lagda.md\\'" . agda2-mode))
                 auto-mode-alist))
  (setq agda2-program-name "/home/trinetra/.cabal/bin/agda-2.6.3"))

(use-package juvix-mode
  :straight (juvix-mode :type git :host github
                        :repo "anoma/juvix-mode"))

(use-package haskell-mode)

(use-package tidal
  :straight (tidal :type git :host github
                        :repo "tidalcycles/tidal"
                        :files ("tidal.el"))
  :config (add-hook 'tidal-mode-hook 'haskell-mode))


(use-package 
  twittering-mode
  :straight (twittering-mode :type git :host github
                             :repo "hayamiz/twittering-mode")
  :config
  (setq twittering-status-format
        "%FACE[bold]{%s}  >>
%FOLD[  ]{%T %QT{
+----
%FOLD[|]{%s %@:
%FOLD[  ]{%T }}
+----}}
 %@ %RT{%R} %r \n")
  (setq twittering-use-master-password t))


;; unicode fonts
(use-package unicode-fonts)
(unicode-fonts-setup)

(set-face-attribute 'default nil
                    :family "mononoki"
                    :height 130
                    :weight 'normal
                    :width  'normal
                    :weight 'semi-bold)

;; preserve cursor position while scrolling
(setq scroll-preserve-screen-position 'always)

;;disable splash screen and startup message
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)


;; ; Use spaces, not tabs.
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)


;; line numbers in prog-mode
(add-hook 'prog-mode-hook 'display-line-numbers-mode)





;; edit as sudo
(use-package sudo-edit)

;; multiple cursors
;; (use-package multiple-cursors
;;   :config (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;;   (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)


;; Fullscreen mode
(defun fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
(fullscreen)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#839496" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(column-number-mode t)
 '(custom-safe-themes
   '("830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "57a29645c35ae5ce1660d5987d3da5869b048477a7801ce7ab57bfb25ce12d3e" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "7fd8b914e340283c189980cd1883dbdef67080ad1a3a9cc3df864ca53bdc89cf" "bbb13492a15c3258f29c21d251da1e62f1abb8bbd492386a673dcfab474186af" "524fa911b70d6b94d71585c9f0c5966fe85fb3a9ddd635362bfabd1a7981a307" "0665cbdcbfcb36a6a6f46201d7a1403b6e9e4111142d341476b4e5a0503a9141" "4b9a39fdca878d390e05c41de2fba39677f9cf38f968822fbfd7b28d0576d248" "6564d76cbcca8667c8b1cd9b84fcf4e38194b840580b54041b7af6d4700f3236" "b1e321e16e1931d67ae923bcf8a776d22737c1b5762a5c70e065c2584de03788" "d1389273b1e873808162f57797a2268241ef7bd35ea41c68800e4d1413bbcf38" "6442249ed0fa52bfef876f2b5000694cb1dc1043e355af4d8c97ffd3bbeb1acb" "480bb091a1af62591966a70aadb5d8d980de6871aa9137f4ed2d64cf311913e4" "36dbbceab40b1c7404a74ee9c6bb56404be42566dc6828148b82785c518be60e" "49297fa29dac4138b2fd3b012799c137df42b2a1c6e438f1a184399a232c46f1" "3b14a618183aa4e2d4096ba4c27d33c3af5d204f4b6e0a024356b0f0be1852d5" "b421f45581ca2f6a437c762f76ded2e494d7906809585abe202245755fbc073f" "2ff0ef94a1ec7cd3b501a3648eba8dda46692f9e74b049da23fc1bf8816947a0" "96ad0457fa1c601434422a49c8d63f1f5af76bef2f8d9cbf9fb8d8e12db4d02f" "d0b97c5949eb083a8488a7302e1d303a4ae0a4b42b1127d84c3ddab708936e0c" "5df1716969cd1ec4c4cf34c0c06ca2720eff1a36b1fa07b456fa3243f0dd6a5e" "1b0d3a7f2f0071f4a581f4f6441ca75ac2e6081526df216a4cdab29ac7181449" "4a550fbda1c8e687dffada9c221173f038d4bf98abe9b0a975fdbd911604e6c2" "8faa6dd53504138adcc1816b52fbb6de9e00d8a15ac1c697b7be818067221e2c" "712157a30c4ea9fc038b6049a292f49f41e1d51767bc2eb351e8dec55c98c258" "633ee641b908da5fdc28a20bab327063b5ba9e38f0b7141e8340289721e5914f" "b8e321d3b3172e26332a4a2fccda2fedd6f1b5413809f408a2766a176cab2731" "55da4d19879c607dd8f88028d8cdb93a7e237057c73ac9e93715698031b19f61" "faad217e6d9c66fcfa211e506c94b03b81d666985d209733d3abb94fe6195e07" "da632895fb2f0880cf2fb454890aded1e2f06877e6bc8551782f6210266d2ca4" "b280c9d77c2e37b6c515ff48499a733bb200c6383cf69f07cfe13504e628d903" "53df1d19a03bf5ef0ddcd1434903f44a8b17a65b2bf52deac224fd9da289a563" "d285c7133d286f35b54a8d09e3cc1b079dccb6087fc3720ef1a002c5f544a6c4" "6af2aec8936b246c9b096264bf55f4d9d8c72f9c4299d7d90dcf19053f4389ff" "1ec80fc0b994d4d05a187909878f7009623c8714afdb1a1eba031d8ea70eb0a5" "8611f406a04d4ef08cbaa859c4a6c5ab616f5f611be17bce2624a3adbef1a37e" "39c5a7ce06afba635fb8d90a2ef072c7b58831d525ccddac8a164428cf126dfe" "b4e94956ff1fbd3feb7d0f85e79fe42a16d0f8a1d1b3767dbe4f9249c44f0e42" "fc27d905d3d14b1a05cf0f8c1da997da95cff7b0c1fb9250cd105a708d876e3a" "730836b6ffaa2936d6c784aa31ee45d518be6aa618deb17cb05e2ce955ad5365" "3f4b99925ee0586ed4c7ece173cea6587e7b07125a367abdd127942224e035ca" "062ced449fe833e4a7e9f7a7a5e6d4ad6f410fa6035224413c9f1c7330a392b9" "bf798e9e8ff00d4bf2512597f36e5a135ce48e477ce88a0764cfb5d8104e8163" "0a1b7b2d4e8931c14e40d87ac58d1e20624307d9a90643e6c96d7aaeb597762b" "296f12a58b5bc587fdf08995a84cb8cdec74b83b794fddaad012e520c411ddf1" "21055a064d6d673f666baaed35a69519841134829982cbbb76960575f43424db" "9ab9441566f7c3b059a205a7c5fad32a58422c2695815436d8cc087860b8c2e5" "64947f83c308d1101f20c6ff86c308497c4d032acb75d8e9dcbc4012d9a3b36e" "1930427eae3d4d830a43fd79fbda76021138b929c243a4e8606cf4f0531ea17c" "634958f8e08a3632c3a609ff3c1f67735907a49add595ac5f938ba0cf7357b4d" "766a50d1b65e702510465ddc7a120c06ec28f219714d200d4684d560979fb2ba" "f149d9986497e8877e0bd1981d1bef8c8a6d35be7d82cba193ad7e46f0989f6a" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "90a6f96a4665a6a56e36dec873a15cbedf761c51ec08dd993d6604e32dd45940" default))
 '(desktop-save-mode t)
 '(display-time-mode t)
 '(doc-view-continuous t)
 '(electric-pair-mode t)
 '(exec-path
   '("/home/trinetra/.local/bin" "/home/trinetra/.cargo/bin" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/games" "/usr/local/games" "/snap/bin" "~/.cargo/bin"))
 '(global-goto-address-mode t)
 '(global-hl-line-mode t)
 '(global-prettify-symbols-mode t)
 '(idris2-interpreter-path "/home/trinetra/.idris2/bin/idris2")
 '(ignored-local-variable-values
   '((hl-sexp-mode)
     (rainbow-mode . t)
     (eval turn-off-auto-fill)))
 '(lispy-no-space t)
 '(lsp-rust-analyzer-server-command '("rust-analyzer"))
 '(lsp-semantic-tokens-enable t)
 '(lsp-ui-doc-position 'at-point)
 '(lsp-ui-doc-use-webkit t)
 '(markdown-command "/usr/bin/pandoc")
 '(markdown-code-lang-modes
   '(("rust" . rustic-mode)
     ("ocaml" . tuareg-mode)
     ("elisp" . emacs-lisp-mode)
     ("ditaa" . artist-mode)
     ("asymptote" . asy-mode)
     ("dot" . fundamental-mode)
     ("sqlite" . sql-mode)
     ("calc" . fundamental-mode)
     ("C" . c-mode)
     ("cpp" . c++-mode)
     ("C++" . c++-mode)
     ("screen" . shell-script-mode)
     ("shell" . sh-mode)
     ("bash" . sh-mode)))
 '(markdown-enable-highlighting-syntax t)
 '(markdown-enable-math t)
 '(menu-bar-mode nil)
 '(safe-local-variable-values
   '((eval turn-off-auto-fill)
     (eval add-hook 'before-save-hook
           (lambda nil
             (org-babel-ref-resolve "onsaveblock"))
           nil t)
     (org-confirm-babel-evaluate)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(visible-bell t))


;; current theme
(use-package solarized-theme
  :config
  (add-hook 'after-init-hook (lambda () (load-theme 'solarized-gruvbox-dark))))

 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(defun dd-bits-pull-buffer ()
  (interactive)
  (let ((bits-dir (init-file-name-concat-home "~/entropy/nubo"))
        (source-components (file-name-split 
                            (init-file-name-concat-home "~/entropy/nubo")))
        (target-components (file-name-split (buffer-file-name))))
    (shell-command
     (concat "rclone sync entropy:/"
             (apply 'file-name-concat (seq-drop target-components
                                                (- (length source-components) 1)))
             " " (file-name-directory (buffer-file-name))))))

(defun dd-bits-push-buffer ()
  (interactive)
  (let ((bits-dir (init-file-name-concat-home "/entropy/nubo"))
        (source-components (file-name-split 
                            (init-file-name-concat-home "/entropy/nubo")))
        (target-components (file-name-split buffer-file-name)))
    (if (string-prefix-p bits-dir (buffer-file-name))
        (shell-command
         (concat "rclone sync " (buffer-file-name) " "
                 "entropy:/"
                 (file-name-directory
                  (apply 'file-name-concat (seq-drop target-components
                                                     (- (length source-components) 1))))))
      (error "Not under nubo directory"))))

