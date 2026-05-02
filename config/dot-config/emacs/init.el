;;; init.el --- custom config  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; =========================
;; ====== Performance ======
;; =========================

;; info on startup time
(defun cst/display-startup-time ()
  "Displays startup time message."
  (message "Emacs loaded in %s with %d garbage collections."
	   (format "%.2f seconds"
		   (float-time
		    (time-subtract after-init-time before-init-time)))
	   gcs-done))

(add-hook 'emacs-startup-hook #'cst/display-startup-time)

;; force full package load when running as daemon
(setq my/force-load (daemonp))

(when my/force-load
  (setq use-package-always-demand t))

;; some stuff taken from https://emacsredux.com/blog/2026/04/07/stealing-from-the-best-emacs-configs/

;; ignore right-to-left text
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; increase buffer size for faster lsp performance
(setq read-process-output-max (* 4 1024 1024)) ; 4MB

;; =========================
;; ======== CLEANUP ========
;; =========================

(setq config/data-dir "var"
	  config/temp-dir "tmp")

(defun var (filename)
  "Get FILENAME under `config/data-dir' directory."
  (locate-user-emacs-file (concat config/data-dir "/" filename)))

(defun tmp (filename)
  "Get FILENAME under `config/temp-dir' directory."
  (locate-user-emacs-file (concat config/data-dir "/" filename)))

;; improve emacs' easy customization
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file)

;; `tmp' is for temporary / unnecessary files
(setopt backup-directory-alist `(("." . ,(tmp "backups/")))
 		auto-save-list-file-prefix (tmp "auto-save-list/.saves-"))

;; `var' will be where we keep data files for plugins
(setopt project-list-file (var "projects")
		eshell-directory-name (var "eshell/")
		recentf-save-file (var "recentf")
		bookmark-default-file (var "bookmark")
		url-configuration-directory (var "url"))

;; drop unused litter
(setopt create-lockfiles nil    ;; drop file locking - emacs only feature, unnecessary
		inhibit-startup-screen t)

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
        (c-sharp "https://github.com/tree-sitter/tree-sitter-c-sharp")
		(rust "https://github.com/tree-sitter/tree-sitter-rust")
        (gitcommit "https://github.com/gbprod/tree-sitter-gitcommit")))

;; =========================
;; ========= MODES =========
;; =========================

(recentf-mode 1)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers 1)
(which-key-mode 1)
(column-number-mode 1)
(setopt display-line-numbers-width 3)
;; disable unnecessary menu bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(set-fringe-mode 10)
;; add line numbers
(pixel-scroll-precision-mode 1)

;; =========================
;; ========= LOOKS =========
;; =========================

;; add themes subdirectory to known themes path
(add-to-list 'load-path (locate-user-emacs-file "themes"))
(add-to-list 'custom-theme-load-path (locate-user-emacs-file "themes"))
;; add plugins subdirectory
(add-to-list 'load-path (locate-user-emacs-file "plugins"))

;; =========================
;; ======== OPTIONS ========
;; =========================

;; make tabs preferred size of 4 spaces
(setq-default tab-width 4)

;; some fixes for indentation
; (setq-default indent-tabs-mode nil)

;; marks tab as just inserting tab
;; for native emacs', set to 'indent-relative
(setq indent-line-function 'insert-tab
	  ring-bell-function 'ignore
	  use-short-answers t)

;; =========================
;; ==== CUSTOM PACKAGES ====
;; =========================

;; Set up package.el to work with MELPA

;; Set up package and use-package
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap 'use-package'
(setopt use-package-always-ensure t)
(setopt use-package-compute-statistics t)

;; looks

;; colors taken from folke's TokyoNight for NeoVim
(use-package modus-themes
  ;; TODO: rewrite as new theme based on modus-themes (possible, check docs)
  :ensure nil
  :custom
  (modus-themes-italic-constructs t)
  (modus-themes-bold-constructs t)
  (modus-themes-mixed-fonts nil)
  (modus-themes-prompts '(bold intense))
  ;; this should be in `modus-vivendi-palette-user' after EMACS 31
  (modus-vivendi-palette-overrides
   '((tk-bg "#1a1b26")
	 (tk-bg-dark "#16161e")
	 (tk-bg-dark1 "#0C0E14")
	 (tk-bg-highlight "#292e42")
	 (tk-blue "#7aa2f7")
	 (tk-blue0 "#3d59a1")
	 (tk-blue1 "#2ac3de")
	 (tk-blue2 "#0db9d7")
	 (tk-blue5 "#89ddff")
	 (tk-blue6 "#b4f9f8")
	 (tk-blue7 "#394b70")
	 (tk-comment "#565f89")
	 (tk-cyan "#7dcfff")
	 (tk-dark3 "#545c7e")
	 (tk-dark5 "#737aa2")
	 (tk-fg "#c0caf5")
	 (tk-fg-dark "#a9b1d6")
	 (tk-fg-gutter "#3b4261")
	 (tk-green "#9ece6a")
	 (tk-green1 "#73daca")
	 (tk-green2 "#41a6b5")
	 (tk-magenta "#bb9af7")
	 (tk-magenta2 "#ff007c")
	 (tk-orange "#ff9e64")
	 (tk-purple "#9d7cd8")
	 (tk-red "#f7768e")
	 (tk-red1 "#db4b4b")
	 (tk-teal "#1abc9c")
	 (tk-terminal-black "#414868")
	 (tk-yellow "#e0af68")
	 (tk-git-add "#449dab")
	 (tk-git-change "#6183bb")
	 (tk-git-delete "#914c54")
	 ;; mode-line
	 (border-mode-line-active "#636388")
	 (border-mode-line-inactive "#3d3d53")
	 ))
  ;; this should be in `modus-operandi-palette-user' after EMACS 31
  (modus-operandi-palette-overrides
   '((tk-bg "#f2f2f2")
	 (tk-bg-dark "#d0d5e3")
	 (tk-bg-dark1 "#c1c9df")
	 (tk-bg-highlight "#c4c8da")
	 (tk-blue "#2e7de9")
	 (tk-blue0 "#7890dd")
	 (tk-blue1 "#188092")
	 (tk-blue2 "#07879d")
	 (tk-blue5 "#006a83")
	 (tk-blue6 "#2e5857")
	 (tk-blue7 "#92a6d5")
	 (tk-comment "#848cb5")
	 (tk-cyan "#007197")
	 (tk-dark3 "#8990b3")
	 (tk-dark5 "#68709a")
	 (tk-fg "#3760bf")
	 (tk-fg-dark "#6172b0")
	 (tk-fg-gutter "#a8aecb")
	 (tk-git-add "#4197a4")
	 (tk-git-change "#506d9c")
	 (tk-git-delete "#c47981")
	 (tk-green "#587539")
	 (tk-green1 "#387068")
	 (tk-green2 "#38919f")
	 (tk-magenta "#9854f1")
	 (tk-magenta2 "#d20065")
	 (tk-orange "#b15c00")
	 (tk-purple "#7847bd")
	 (tk-red "#f52a65")
	 (tk-red1 "#c64343")
	 (tk-teal "#118c74")
	 (tk-terminal-black "#a1a6c5")
	 (tk-yellow "#8c6c3e")
	 ;; mode-line
	 (border-mode-line-active "#6374a2")
	 (border-mode-line-inactive "#99a4c3")
	 ))
  (modus-themes-common-palette-overrides
   '(;; general
	 (bg-main tk-bg)
	 (fg-main tk-fg)
	 (bg-dim tk-bg-dark1)
	 (cursor tk-fg)
	 (border tk-terminal-black)
	 (fg-line-number-inactive tk-fg-gutter)
	 (fg-line-number-active tk-fg-gutter)
	 (bg-line-number-inactive nil)
	 (bg-line-number-active tk-bg)
	 ;; fringes
	 (fringe bg-main)
	 ;; prominent??
	 (bg-prominent-err nil)
	 (fg-prominent-err err)
	 (bg-prominent-warning nil)
	 (fg-prominent-warning warning)
	 (bg-prominent-note nil)
	 (fg-prominent-note info)
	 ;; programming
	 (builtin tk-cyan)
	 (comment tk-comment)
	 (constant tk-orange)
	 (docstring tk-blue6)
	 (fnname tk-blue)
	 (keyword tk-purple)
	 (number tk-orange)
	 (property tk-green1)
	 (string tk-green)
	 (type tk-blue1)
	 (variable fg-main)
	 ;; error messages
	 (err tk-red)
	 (info tk-blue1)
	 (warning tk-yellow)
	 (underline-err err)
	 (underline-note info)
	 (underline-warning warning)
	 ;; prose
	 (fg-link-visited tk-purple)
	 (fg-prose-verbatim constant)
	 (prose-todo tk-blue)
	 (prose-done tk-green)
	 (underline-link-visited tk-purple)
	 ;; mode-line
	 (bg-mode-line-active tk-bg-dark)
	 (fg-mode-line-active tk-fg)
	 (bg-mode-line-inactive tk-bg-dark1)
	 (fg-mode-line-inactive tk-fg-dark)
	 (modeline-err err)
	 (modeline-warning warning)
	 (modeline-info info)
	 ))
  :config
  (add-hook 'enable-theme-functions
			(lambda (theme)
			  (if (string-equal theme "modus-vivendi")
				  (set-frame-parameter nil 'alpha-background 68)
				  (set-frame-parameter nil 'alpha-background 85))))
  :init
  (load-theme 'modus-vivendi t))

(use-package auto-dark
  :ensure t
  :custom
  (auto-dark-themes '((modus-vivendi) (modus-operandi)))
  (auto-dark-polling-interval-seconds 5)
  :init (auto-dark-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; just for colorscheme testing purposes
(defun asdfffffffffffffffffffff ()
  ;; comment
  "docstring."
  (interactive)
  (find-file user-init-file))

(use-package nerd-icons
  :ensure t
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  :custom
  (nerd-icons-font-family "Symbols Nerd Font"))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :custom
  (hl-todo-highlight-punctuation ":")
  (hl-todo-keyword-faces
   `(("TODO"       warning bold)
     ("FIXME"      error bold)
     ("BUG"        error bold)
     ("HACK"       font-lock-constant-face bold)
     ("REVIEW"     font-lock-keyword-face bold)
     ("NOTE"       success bold)
     ("DEPRECATED" font-lock-doc-face bold))))

(defun evil-paste-clipboard ()
  "Paste before on clipboard content."
  (interactive)
  (evil-paste-after nil ?+))

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

  ;; copy and paste commands to mimic terminal behavior
  (evil-define-key '(normal visual) 'global (kbd "C-S-c") 'evil-yank)
  (evil-define-key 'visual 'global (kbd "C-S-v") 'evil-paste-clipboard)
  (evil-define-key 'insert 'global (kbd "C-S-v") 'evil-paste-clipboard)
  
  ;; (evil-define-key 'command 'global (kbd "<C-S-v>") 'evil-yank)
  ;; vim.keymap.set('v', '<C-S-v>', '"+P', { desc = 'Paste from clipboard' })
  ;; vim.keymap.set('i', '<C-S-v>', '<ESC>"+Pa', { desc = 'Paste from clipboard' })
  ;; vim.keymap.set('c', '<C-S-v>', '<C-r>+', { desc = 'Paste from clipboard' })

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-commentary
  :ensure t
  :init
  (evil-commentary-mode))

(use-package flycheck
  :defer (not my/force-load)
  :config
  (evil-define-key 'normal 'flycheck-mode (kbd "]d") 'flycheck-next-error)
  (evil-define-key 'normal 'flycheck-mode (kbd "[d") 'flycheck-previous-error)
  (evil-define-key 'normal 'flycheck-mode (kbd "gl") 'flycheck-display-error-at-point))

;; =========================
;; ======= PLAINTEXT =======
;; =========================

(use-package visual-fill-column
  :hook
  (text-mode . visual-fill-column-mode)
  (text-mode . visual-line-mode)
  :custom
  (visual-fill-column-center-text t))

;; =========================
;; ========== LSP ==========
;; =========================

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-eldoc-enable-hover t)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-lens-enable nil)
  (lsp-diagnostic-provider :flycheck)
  (lsp-completion-provider :none)
  (lsp-enable-which-key-integration t)
  (lsp-modeline-code-action-icons-enable nil)
  (lsp-session-file (var "lsp-session-v1"))
  (lsp-modeline-code-actions-enable nil)
  :config
  (evil-define-key 'normal 'lsp-mode (kbd "K") 'lsp-ui-doc-glance)
  (evil-define-key 'normal 'lsp-mode (kbd "gdd") 'lsp-find-definition)
  (evil-define-key 'normal 'lsp-mode (kbd "gdt") 'lsp-find-type-definition)
  (evil-define-key 'normal 'lsp-mode (kbd "gD") 'lsp-find-type-declaration)
  (evil-define-key 'normal 'lsp-mode (kbd "gi") 'lsp-find-implementation)
  (evil-define-key 'normal 'lsp-mode (kbd "gr") 'lsp-find-references)

  ;; code actions
  (evil-define-key 'normal 'lsp-mode (kbd "<leader>ca") 'lsp-execute-code-action)
  (evil-define-key 'normal 'lsp-mode (kbd "<leader>cr") 'lsp-rename))

(use-package lsp-ui
  :after lsp-mode
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
  (completion-styles '(flex orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  (corfu-on-exact-match 'insert) ;; Configure handling of exact matches
  (corfu-preselect 'prompt)
  :bind
  (:map corfu-map
		("TAB" . corfu-next)
		([tab] . corfu-next)
		("S-TAB" . corfu-previous)
		([backtab] . corfu-previous))
  :init
  (global-corfu-mode)
  ;; extensions
  (corfu-popupinfo-mode))

;; =========================
;; ======= ORG MODE ========
;; =========================

(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; define files
(setopt org-default-notes-file "~/org/refile.org")
(setopt org-hide-leading-stars nil)

;; add some keybinds
(evil-define-key 'normal 'global (kbd "<leader>oa") 'org-agenda)
(evil-define-key 'normal 'global (kbd "<leader>oc") 'org-capture)

(defun cst/org-mode ()
  "Customize org mode."
  (org-indent-mode)
  (setopt fill-column 100))

(add-hook 'org-mode-hook 'cst/org-mode)

(use-package denote)

;; =========================
;; ======= PROG MODE =======
;; =========================

(add-hook 'prog-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'prog-mode-hook #'electric-pair-local-mode)

(use-package prog-mode
  :ensure nil
  :hook
  (prog-mode . display-line-numbers-mode))

;; treesit
(setopt treesit-font-lock-level 4)

(use-package zig-mode
  :mode "\\.\\(zig\\|zon\\)\\'"
  :hook (zig-mode . lsp-deferred))

(defun open-test-file ()
  "Opens golang test file for current file."
  (interactive nil go-ts-mode)
  (let ((dir (file-name-directory buffer-file-name))
		(extension (file-name-extension buffer-file-name))
		(name (file-name-base buffer-file-name)))
	(when (string-match-p "_test$" name)
	  (error "Already in test file!"))
	(find-file (concat dir name "_test." extension))))

(use-package go-ts-mode
  :mode "\\.go\\'"
  :hook
  (go-ts-mode . lsp-deferred)
  :init
  ;; because cannot put in :mode block
  (add-to-list 'auto-mode-alist '("/go\\.mod\\'" . go-mod-ts-mode))
  :config
  (setq go-ts-mode-indent-offset 4))

(use-package templ-ts-mode
  :mode "\\.templ\\'")

(use-package lua-mode
  :interpreter "lua"
  :mode "\\.lua\\'")

(use-package csharp-ts-mode
  :ensure nil
  :mode "\\.cs\\'"
  :hook (csharp-ts-mode . lsp-deferred))

;; ocaml mode
(use-package tuareg
  :mode
  (("\\.ocamlinit\\'" . tuareg-mode))
  :hook
  (tuareg-mode . lsp-deferred))

(use-package merlin
  :after tuareg
  :hook (tuareg-mode . merlin-mode))

(use-package opam-switch-mode
  :after tuareg
  :hook (tuareg-mdoe . opam-switch-mode))

;; This uses Merlin internally
(use-package flycheck-ocaml
  :after tuareg
  :config
  (flycheck-ocaml-setup))

;; Major mode for editing Dune project files
(use-package dune
  :ensure t
  :after tuareg)

(use-package utop
  :ensure t
  :after tuareg
  :custom
  (utop-command "opam exec -- dune utop . -- -emacs"))

(use-package eshell
  :defer (not my/force-load)
  :ensure nil
  :hook
  ;; enable coloring for eshell
  (eshell-mode . (lambda () (setenv "TERM" "xterm-256color"))))

(use-package rust-mode
  :ensure nil
  :hook (rust-mode . lsp-deferred)
  ;; :init
  ;; (add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))
  )

;; =========================
;; ======== (MA)GIT ========
;; =========================

(use-package magit
  :defer (not my/force-load)
  :custom
  (git-commit-major-mode 'git-commit-ts-mode))

;; =========================
;; ======== COMMAND ========
;; =========================

(defun open-user-init ()
  "Opens init.el file."
  (interactive)
  (find-file user-init-file))

;;; init.el ends here
