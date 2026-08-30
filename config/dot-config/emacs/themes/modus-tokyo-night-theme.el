;;; modus-tokyo-night-theme.el --- Tokyo Night theme based on Modus Themes  -*- lexical-binding: t; -*-

;;; Commentary:
;;  Colorscheme based on folke's TokyoNight for NeoVim

;;; Code:

(modus-themes-theme
  'modus-tokyo-night
  modus-vivendi-palette
  )

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
   '((:tk-bg "#1a1b26")
	 (:tk-bg-dark "#16161e")
	 (:tk-bg-dark1 "#0C0E14")
	 (:tk-bg-highlight "#292e42")
	 (:tk-blue "#7aa2f7")
	 (:tk-blue0 "#3d59a1")
	 (:tk-blue1 "#2ac3de")
	 (:tk-blue2 "#0db9d7")
	 (:tk-blue5 "#89ddff")
	 (:tk-blue6 "#b4f9f8")
	 (:tk-blue7 "#394b70")
	 (:tk-comment "#565f89")
	 (:tk-cyan "#7dcfff")
	 (:tk-dark3 "#545c7e")
	 (:tk-dark5 "#737aa2")
	 (:tk-fg "#c0caf5")
	 (:tk-fg-dark "#a9b1d6")
	 (:tk-fg-gutter "#3b4261")
	 (:tk-green "#9ece6a")
	 (:tk-green1 "#73daca")
	 (:tk-green2 "#41a6b5")
	 (:tk-magenta "#bb9af7")
	 (:tk-magenta2 "#ff007c")
	 (:tk-orange "#ff9e64")
	 (:tk-purple "#9d7cd8")
	 (:tk-red "#f7768e")
	 (:tk-red1 "#db4b4b")
	 (:tk-teal "#1abc9c")
	 (:tk-terminal-black "#414868")
	 (:tk-yellow "#e0af68")
	 (:tk-git-add "#449dab")
	 (:tk-git-change "#6183bb")
	 (:tk-git-delete "#914c54")))
  ;; this should be in `modus-operandi-palette-user' after EMACS 31
  (modus-operandi-palette-overrides
   '((:tk-bg "#f2f2f2")
	 (:tk-bg-dark "#d0d5e3")
	 (:tk-bg-dark1 "#c1c9df")
	 (:tk-bg-highlight "#c4c8da")
	 (:tk-blue "#2e7de9")
	 (:tk-blue0 "#7890dd")
	 (:tk-blue1 "#188092")
	 (:tk-blue2 "#07879d")
	 (:tk-blue5 "#006a83")
	 (:tk-blue6 "#2e5857")
	 (:tk-blue7 "#92a6d5")
	 (:tk-comment "#848cb5")
	 (:tk-cyan "#007197")
	 (:tk-dark3 "#8990b3")
	 (:tk-dark5 "#68709a")
	 (:tk-fg "#3760bf")
	 (:tk-fg-dark "#6172b0")
	 (:tk-fg-gutter "#a8aecb")
	 (:tk-git-add "#4197a4")
	 (:tk-git-change "#506d9c")
	 (:tk-git-delete "#c47981")
	 (:tk-green "#587539")
	 (:tk-green1 "#387068")
	 (:tk-green2 "#38919f")
	 (:tk-magenta "#9854f1")
	 (:tk-magenta2 "#d20065")
	 (:tk-orange "#b15c00")
	 (:tk-purple "#7847bd")
	 (:tk-red "#f52a65")
	 (:tk-red1 "#c64343")
	 (:tk-teal "#118c74")
	 (:tk-terminal-black "#a1a6c5")
	 (:tk-yellow "#8c6c3e")))
  (modus-themes-common-palette-overrides
   '(;; general
	 (bg-main :tk-bg)
	 (fg-main :tk-fg)
	 (cursor :tk-fg)
	 (fg-line-number-inactive :tk-fg-gutter)
	 (fg-line-number-active :tk-fg-gutter)
	 (bg-line-number-inactive nil)
	 (bg-line-number-active :tk-bg)
	 ;; prominent??
	 (bg-prominent-err nil)
	 (fg-prominent-err err)
	 (bg-prominent-warning nil)
	 (fg-prominent-warning warning)
	 (bg-prominent-note nil)
	 (fg-prominent-note info)
	 ;; programming
	 (builtin :tk-cyan)
	 (comment :tk-comment)
	 (constant :tk-orange)
	 (docstring :tk-blue6)
	 (fnname :tk-blue)
	 (keyword :tk-purple)
	 (number :tk-orange)
	 (string :tk-green)
	 (type :tk-teal)
	 (variable fg-main)
	 ;; error messages
	 (err :tk-red)
	 (info :tk-blue2)
	 (warning :tk-yellow)
	 (underline-err err)
	 (underline-note info)
	 (underline-warning warning)
	 ;; prose
	 (fg-link-visited :tk-purple)
	 (fg-prose-verbatim constant)
	 (prose-todo :tk-blue)
	 (prose-done :tk-green)
	 (underline-link-visited :tk-purple)))
  :config
  (add-hook 'enable-theme-functions
			(lambda (theme)
			  (if (string-equal theme "modus-vivendi")
				  (set-frame-parameter nil 'alpha-background 68)
				  (set-frame-parameter nil 'alpha-background 85))))
  :init
  (load-theme 'modus-vivendi t))
