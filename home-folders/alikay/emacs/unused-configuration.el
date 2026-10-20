;; This file is *NOT* imported by anything, I use it to store configuration i'm not activly using

; LSP Support
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         (bash-ts-mode . lsp)
	 (c-mode . lsp)
	 (c++-mode . lsp)
	 (css-mode . lsp)
	 (csharp-mode . lsp)
	 (html-mode . lsp)
	 (js-mode . lsp)
	 (python-mode . lsp)
	 (rust-ts-mode . lsp)
	 ; (nix-ts-mode . lsp) ; Disabled because nix eval uses 10gb of memory and then coredumps
	 
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-show-diagnostics nil))
  ;(setq lsp-ui-doc-show-with-cursor t)) ; Done by flycheck instead
