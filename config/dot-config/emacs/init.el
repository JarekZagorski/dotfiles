;;; init.el --- custom config  -*- lexical-binding: t; -*-

;; =========================
;; ======= Utilities =======
;; =========================

(defun cst/locate-file (filename)
  "Combines Emacs runtime path with provided FILENAME."
  (concat user-emacs-directory filename))

;; =========================
;; ====== Performance ======
;; =========================
(setq gc-cons-threshold (* 50 1000 1000))

;; info on startup time
(defun cst/display-startup-time ()
  "Displays startup time message."
  (message "Emacs loaded in %s with %d garbage collections."
	   (format "%.2f seconds"
		   (float-time
		    (time-subtract after-init-time before-init-time)))
	   gcs-done))

(add-hook 'emacs-startup-hook #'cst/display-startup-time)

;; Do not show startup message
(setq inhibit-startup-message t)

;; improve emacs' easy customization
(setq custom-file (cst/locate-file "custom.el"))
(load custom-file)
;; (setq scroll-margin 12)

;; =========================
;; ====== TREE SITTER ======
;; =========================

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (cmake "https://github.com/uyha/tree-sitter-cmake")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (go "https://github.com/tree-sitter/tree-sitter-go" "v0.25.0")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (make "https://github.com/alemuller/tree-sitter-make")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")
        (gitcommit "https://github.com/gbprod/tree-sitter-gitcommit")))

;; =========================
;; ========= MODES =========
;; =========================

(recentf-mode 1)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers 1)
(which-key-mode 1)
(column-number-mode 1) ;; for static size number column
(setopt display-line-numbers-width 3)
;; disable unnecessary menu bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(set-fringe-mode 10)
;; add line numbers
(global-display-line-numbers-mode 1)
(pixel-scroll-precision-mode 1)

;; =========================
;; ========= LOOKS =========
;; =========================

(add-to-list 'default-frame-alist '(alpha-background . 85))
(add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; font
(add-to-list 'default-frame-alist '(font . "Fira Code 12" ))

;; set window opacity
(set-frame-parameter nil 'alpha-background 85)
(set-frame-parameter nil 'undecorated t)

;; theme
; (load-theme 'deeper-blue t)

;; add themes subdirectory to known themes path
(add-to-list 'load-path (cst/locate-file "themes"))
(add-to-list 'custom-theme-load-path (cst/locate-file "themes"))

(load-theme 'zenburn t)

;; add plugins subdirectory
(add-to-list 'load-path
	     (expand-file-name (locate-user-emacs-file "plugins")))

;; =========================
;; ======== OPTIONS ========
;; =========================

;; make tabs preferred size of 4 spaces
(setq-default tab-width 4)

;; some fixes for indentation
; (setq-default indent-tabs-mode nil)

;; marks tab as just inserting tab
;; for native emacs', set to 'indent-relative
(setq indent-line-function 'insert-tab)

;; =========================
;; ==== CUSTOM PACKAGES ====
;; =========================

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(setq use-package-always-ensure t)
;; is for refreshing packages
;; (package-refresh-contents)

;; looks

(use-package nerd-icons
  :ensure t
  :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  (nerd-icons-font-family "Fira Code"))

;; Download and Enable Evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t
	evil-want-keybinding nil
	evil-want-C-u-scroll t
	evil-want-C-i-jump t
	;; disables copying to clipboard when using motions
	select-enable-clipboard nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-set-undo-system 'undo-redo))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package flycheck)

;; =========================
;; ========== LSP ==========
;; =========================

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  ; :hook
  ; (go-mode . lsp)
  ; (zig-mode . lsp)
  :config
  (lsp-enable-which-key-integration t))

;; =========================
;; ========== GIT ==========
;; =========================

(use-package git-modes)

(use-package git-commit-ts-mode
  :mode "\\COMMIT_EDITMSG\\'")

;; =========================
;; ======= PROG MODE =======
;; =========================

(use-package zig-mode
  :mode "\\.\\(zig\\|zon\\)\\'"
  :hook (zig-mode . lsp-deferred))

(use-package go-ts-mode
  :mode "\\.go\\'"
  :hook (go-ts-mode . lsp-deferred)
  :init
  ;; because cannot put in :mode block
  (add-to-list 'auto-mode-alist '("/go\\.mod\\'" . go-mod-ts-mode))
  :config
  (setq go-ts-mode-indent-offset 4))

;;; init.el ends here
