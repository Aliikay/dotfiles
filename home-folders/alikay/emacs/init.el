;; -- Initalize Package Sources --
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
   (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; -- Basic Setup --
(tool-bar-mode -1) ; Hide the toolbar
(menu-bar-mode 1) ; Show the menubar (File, Edit, etc...)
;(tab-bar-mode 1) ; Show tabs bar at the top
;(setq tab-bar-show 1) ; Only show tabs when > 1 tab is open
(setq inhibit-startup-message t) ; Hide the splash screen
(setq visible-bell t) ; Flash the top and bottom of the screen when the bell would ring
(setq echo-keystrokes 0.01) ; Show keystrokes in the bottom immediatly
(setq-default cursor-type 'bar) ; Make the cursor a bar instead of a block
(setq sentence-end-double-space nil) ; Prevent adding two spaces after periods
(setq delete-by-moving-to-trash t) ; Delete moves to trash instead of deleting
;(pixel-scroll-mode 1) ; Make scrolling pixel based instead of character based
(setq-default cursor-in-non-selected-windows nil) ; Don't draw cursors in non selected windows
(setq highlight-nonselected-windows nil) ; Don't do selection highlighting in non focused windows
(global-goto-address-mode) ; Make URL's links
(setq word-wrap t)
(setq wrap-prefix (make-string 30 ?\s))

;   Line Numbers
(column-number-mode)
(global-display-line-numbers-mode 1)
(dolist (mode '(org-mode-hook ; Don't display line numbers in the following modes
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

; Prevent filesystem clutter
(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

; Dired setup
(setq
 dired-create-destination-dirs 'ask
 dired-kill-when-opening-new-dired-buffer t ; Don't open each directory in a new buffer
 dired-do-revert-buffer t
 )

; Set font
(set-face-attribute 'default nil
		    :family "Space Mono"
		    :height 120
		    :weight 'normal
		    :width 'normal)

;; -- Packages --
;(use-package gruvbox-theme
;  :ensure t
;  :config
					;  (load-theme 'gruvbox t))

(use-package doom-themes
  :config
  (let ((chosen-theme 'doom-gruvbox))
    (doom-themes-visual-bell-config)
    (doom-themes-org-config)
    (setq doom-challenger-deep-brighter-comments t
          doom-challenger-deep-brighter-modeline t
          doom-rouge-brighter-comments t
          doom-ir-black-brighter-comments t
          modus-themes-org-blocks 'gray-background
          doom-dark+-blue-modeline nil)
    (load-theme chosen-theme t)))

(use-package rainbow-delimiters ; Rainbow brackets
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key ; Show kbd shortcuts when in the middle of a shortcut
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 2))

(use-package nix-ts-mode ; Major mode for editing .nix files
  :mode "\\.nix\\'")

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
	 (nix-ts-mode . lsp)
	 
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(setq read-process-output-max (* 1024 1024)) ; Allow LSP to read a sensible amount of data

(use-package doom-modeline ; Fancy modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; -- Custom --
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326"
     "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
