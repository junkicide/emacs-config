;; rust.el
;;   Configure rust development via lsp and rust-analyzer
;;
;; This mode enables IDE-like integration for writing and editing rust
;; mode, as well as projectile.el, a utility to mark projects in a
;; large set of directories such as a monorepo.  This mode depends on
;; all projects in this tree following the projectile conventions.
;;
;;
;; This file is part of LIBKOOKIE, a collection of nix expressions.
;; LIBKOOKIE is licensed under the GPL-3.0 (or later) -- see LICENSE

(provide 'rust)

(require 'yasnippet)

;;; Use rust-analyzer for completions
(setq lsp-rust-server 'rust-analyzer)

;;; what to use when checking on save
(setq lsp-rust-analyzer-cargo-watch-command "clippy")

;;inlay hints
(setq lsp-rust-analyzer-server-display-inlay-hints t)

;;; Start lsp mode for Rust buffers
(add-hook 'rustic-mode-hook #'lsp)

;;; Start the yas-minor-mode for Rust buffers
(add-hook 'rustic-mode-hook #'yas-minor-mode)

;;; Use projectile to find project roots
(projectile-mode t)
(setq lsp-auto-guess-root t)

;;; rustfmt on save
 (setq rustic-format-on-save t)

(setq lsp-ui-doc-position 'top)
(setq lsp-ui-doc-max-width 40)
(setq lsp-ui-doc-max-height 20)
