;;; packages.el --- bao-customization layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Bao Nguyen Quoc <baonguyen@Baos-MacBook-Pro.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `bao-customization-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `bao-customization/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `bao-customization/pre-init-PACKAGE' and/or
;;   `bao-customization/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst bao-customization-packages
  '(
    js2-mode
    go-mode
    company-go
    company-terraform
    elpy
   )
  "The list of Lisp packages required by the bao-customization layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


(defun bao-customization/init-elpy ()
  (use-package elpy)
  (elpy-enable)
  (add-hook 'python-mode-hook (lambda()
                                (local-set-key (kbd "s-.") 'elpy-goto-definition)
                               )
   )
  )

(defun bao-customization/init-go-mode ()
  (use-package go-mode)
  )

(defun bao-customization/init-company-go ()
  (use-package company-go)
  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "s-.") 'godef-jump)
                            (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode)
                            ))
  )

(defun bao-customization/init-js2-mode ()
  (use-package js2-mode)
  )


(defun bao-customization/init-company-terraform ()
  (use-package company-terraform)
  (company-terraform-init)
  ; broken: https://github.com/rafalcieslak/emacs-company-terraform/issues/3
  ; (add-hook 'terraform-mode-hook (lambda()
  ;                                  (company-mode)
  ;                                  ))
  )

(define-key global-map [home] 'beginning-of-line)
(define-key global-map [end] 'end-of-line)

(global-set-key (kbd "<f12>") (lambda() (interactive)(find-file "~/.emacs.d/private/bao-customization/packages.el")))

(global-set-key (kbd "s-<left>") 'move-beginning-of-line)
(global-set-key (kbd "s-<right>") 'move-end-of-line)
(global-set-key (kbd "s-<up>") 'scroll-up-command)
(global-set-key (kbd "s-<down>") 'scroll-down-command)
(global-set-key (kbd "C-x <down>") 'helm-mini)
(spacemacs/set-leader-keys ":" 'eval-expression)
(spacemacs/set-leader-keys "f g" 'find-grep-dired)
(spacemacs/set-leader-keys "g c" 'magit-checkout)
(spacemacs/set-leader-keys "g F" 'magit-fetch-all)

; start server so we can use emacsclient
(server-start)
(setq server-socket-dir "~/.emacs.d/server")

;; make python output faster
;; See here for how to clear python shell buffer https://stackoverflow.com/questions/8054953/how-to-clear-ipython-buffer-in-emacs
(setq python-shell-enable-font-lock nil)

;; Use zsh for eshell
;; (setq explicit-shell-file-name "/bin/zsh")
(setq shell-default-shell 'multi-term)


;;; packages.el ends here
