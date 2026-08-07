;; Basic Setup
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq inhibit-startup-message t)
(setq visible-bell t)
;;(setq ring-bell-function 'ignore)
(setq echo-keystrokes 0.01)
(setq-default cursor-type 'bar)

;; Environment
(set-face-attribute 'default nil
		    :family "Space Mono"
		    :height 120
		    :weight 'normal
		    :width 'normal)


;; Initalize Package Sources
(require 'package)
(setq package-atchives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
   (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Packages
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

;; Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
