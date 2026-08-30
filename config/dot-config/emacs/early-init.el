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

;; to avoid flashbang
(add-to-list 'default-frame-alist '(background-color . "#16161e"))
;; good initials
(add-to-list 'default-frame-alist '(alpha-background . 68))
(add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; font
(add-to-list 'default-frame-alist '(font . "Fira Code 12"))

(setq initial-frame-alist (delete '(vertical-scroll-bars) initial-frame-alist))


;; single vc-backend helps improve startup speed
(setq vc-handled-backends '(Git))

;; =============================================================
;; === testing: https://www.jamescherti.com/compiling-emacs/ ===
;; =============================================================

;; Display the architecture using:
;;   gcc -march=native -Q --help=target | grep march
;;
;; The above command asks the compiler to resolve native for your current CPU
;; and display the resulting target. For example, if the output shows
;; -march=skylake, you know that skylake is the identifier you should pass to
;; -mtune and -march.
(setq my-cpu-architecture "znver2")

;; `native-comp-compiler-options' specifies flags passed directly to the C
;; compiler (for example, GCC) when compiling the Lisp-to-C output
;; produced by the native compilation process. These flags affect code
;; generation, optimization, and debugging information.
(setq native-comp-compiler-options `(;; The most meaningful optimizations:
                                     "-O2"
                                     ,(format "-mtune=%s" my-cpu-architecture)
                                     ,(format "-march=%s" my-cpu-architecture)
                                     ;; Reduce .eln size and compilation
                                     ;; overhead.
                                     "-g0"
                                     ;; Good defensive choice for Emacs
                                     ;; stability.
                                     "-fno-omit-frame-pointer"
                                     "-fno-finite-math-only"))

(setq native-comp-driver-options '(;; -Wl,-z,pack-relative-relocs compresses
                                   ;; relocation tables to reduce file size and
                                   ;; slightly improve load times.
                                   "-Wl,-z,pack-relative-relocs"
                                   ;; -Wl,-O2 applies standard linker-level
                                   ;; optimizations (like string merging) to the
                                   ;; generated shared object.
                                   "-Wl,-O2"
                                   ;; -Wl,--as-needed prevents the linker from
                                   ;; recording dependencies on libraries that
                                   ;; are not actually used by the code.
                                   "-Wl,--as-needed"))

;;; early-init.el ends here
