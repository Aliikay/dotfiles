;; This file is *NOT* imported by anything, I use it to store configuration i'm not activly using

(use-package eglot
  :defer t
  :hook ((bash-ts-mode . eglot-ensure)
	 (c-mode . eglot-ensure)
	 (c++-mode . eglot-ensure)
	 (css-mode . eglot-ensure)
	 (csharp-mode . eglot-ensure)
	 (html-mode . eglot-ensure)
	 (js-mode . eglot-ensure)
	 (python-mode . eglot-ensure)
	 (rust-ts-mode . eglot-ensure)))
					; (nix-ts-mode . lsp) ; Disabled because nix eval uses 10gb of memory and then coredumps)

; Corfu for completions
(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match 'insert) ;; Configure handling of exact matches

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  :init

  ;; Recommended: Enable Corfu globally.  Recommended since many modes provide
  ;; Capfs and Dabbrev can be used globally (M-/).  See also the customization
  ;; variable `global-corfu-modes' to exclude certain modes.
  (global-corfu-mode)

  ;; Enable optional extension modes:
  ;; (corfu-history-mode)
  ;; (corfu-mouse-mode)
  ;; (corfu-popupinfo-mode)
  )


