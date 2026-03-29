;;; early-init.el --- Pre-startup config for better performance  -*- lexical-binding: t; -*-

;;; Commentary:
;;  Startup settings for better performance; some sources:
;;  - Emacs Solo (https://github.com/LionyxML/emacs-solo)

;;; Code:

;; delay gc collections for init phase

(setq gc-cons-threshold most-positive-fixnum
	  gc-cons-percentage 1.0)

;; set better gc defaults after init
(add-hook 'after-init-hook
		  (lambda ()
			(setq gc-cons-threshold (* 100 1024 1024)
				  gc-cons-percentage 0.6)))

;; single vc-backend helps improve startup speed
(setq vc-handled-backends '(Git))

;;; early-init.el ends here
