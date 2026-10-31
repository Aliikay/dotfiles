; Set BG color to match theme to prevent white flash when loading
(setq default-frame-alist '(
			    (background-color . "#282828")
			    (ns-appearance . dark)
			    (ns-transparent-titlebar . t))) 

; Force lsp-mode to use plists for performance
; (setenv "LSP_USE_PLISTS" "true")
