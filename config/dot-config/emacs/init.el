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
;; add plugins subdirectory
(add-to-list 'load-path (cst/locate-file "plugins"))

(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'mocha))

(load-theme 'catppuccin t)

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

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :custom
  (hl-todo-highlight-punctuation ":")
  (hl-todo-keyword-faces
   `(("TODO"       warning bold)
     ("FIXME"      error bold)
     ("BUG"      error bold)
     ("HACK"       font-lock-constant-face bold)
     ("REVIEW"     font-lock-keyword-face bold)
     ("NOTE"       success bold)
     ("DEPRECATED" font-lock-doc-face bold))))

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

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-set-undo-system 'undo-redo)

  (evil-set-leader 'normal (kbd "SPC"))

  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  )

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package flycheck
  :config
  (evil-define-key 'normal 'flycheck-mode (kbd "]d") 'flycheck-next-error)
  (evil-define-key 'normal 'flycheck-mode (kbd "[d") 'flycheck-previous-error))

;; =========================
;; ========== LSP ==========
;; =========================

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((go-ts-mode . lsp-deferred)
		 (zig-mode . lsp-deferred))
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-eldoc-enable-hover t)
  (lsp-headerline-breadcrumb-enable nil)
  :config
  (lsp-enable-which-key-integration t)
  (evil-define-key 'normal 'lsp-mode (kbd "K") 'lsp-ui-doc-glance)
  (evil-define-key 'normal 'lsp-mode (kbd "gdd") 'lsp-find-definition)
  (evil-define-key 'normal 'lsp-mode (kbd "gdt") 'lsp-find-type-definition)
  (evil-define-key 'normal 'lsp-mode (kbd "gD") 'lsp-find-type-declaration)
  (evil-define-key 'normal 'lsp-mode (kbd "gi") 'lsp-find-implementation)
  (evil-define-key 'normal 'lsp-mode (kbd "gr") 'lsp-find-references)

  ;; code actions
  (evil-define-key 'normal 'lsp-mode (kbd "<leader>ca") 'lsp-execute-code-action))

(use-package lsp-ui
  :config
  (lsp-ui-doc-enable t))

;; =========================
;; ========== GIT ==========
;; =========================

(use-package git-modes)

(use-package git-commit-ts-mode
  :mode "\\COMMIT_EDITMSG\\'")

;; =========================
;; ====== Completions ======
;; =========================

;; Enable Vertico.
(use-package vertico
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Emacs minibuffer configurations.
(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt))

  ;; corfu
  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

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
  ;; (corfu-popupinfo-mode)
  )

;; =========================
;; ======= PROG MODE =======
;; =========================

(use-package zig-mode
  :mode "\\.\\(zig\\|zon\\)\\'")

(use-package go-ts-mode
  :mode "\\.go\\'"
  :init
  ;; because cannot put in :mode block
  (add-to-list 'auto-mode-alist '("/go\\.mod\\'" . go-mod-ts-mode))
  :config
  (setq go-ts-mode-indent-offset 4))

;;; init.el ends here
