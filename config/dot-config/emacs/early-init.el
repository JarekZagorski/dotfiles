;;; early-init.el --- Pre-startup config for better performance  -*- lexical-binding: t; -*-

;;; Commentary:
;;  Startup settings for better performance; some sources:
;;  - Emacs Solo (https://github.com/LionyxML/emacs-solo)

;;; Code:

;; delay gc collections for init phase

(setq gc-cons-threshold most-positive-fixnum
	  gc-cons-percentage 1.0)

;; set better gc defaults after init
(defun set-gc-options ()
  (setq gc-cons-threshold (* 100 1024 1024)
		gc-cons-percentage 0.1))

(add-hook 'after-init-hook 'set-gc-options)

;; avoid flashbang
(defun avoid-flashbang ()
  (setq mode-line-format nil)
  (let ((bg "#16161e"))
	(set-face-attribute 'default nil
						:background bg
						:foreground bg)))
(avoid-flashbang)

;; single vc-backend helps improve startup speed
(setq vc-handled-backends '(Git))

;;; early-init.el ends here
