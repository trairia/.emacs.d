;;;; init.el --- user initialize script
;;; commentary:

;;; code:
;;;; General Setting
;; Package Repository

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Custom-set-variable file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)
;; req-package
(eval-when-compile
  (require 'use-package))
(require 'use-package)
(require 'req-package)

;; disable startup screen
(setq inhibit-startup-screen t)

;; disable ring-bell
(setq ring-bell-function 'ignore)

;; Keybind
(keyboard-translate ?\C-h ?\C-?)

;; auto-compile init.el
(setq load-prefer-newer t)
(use-package auto-compile
  :config
  (progn
    (auto-compile-on-load-mode)
    (auto-compile-on-save-mode)))

;; indent
(setq-default indent-tabs-mode nil)

;;;; platform
(if (string-equal system-type "windows-nt")
    (setq platform-binary-prefix ".exe")
  )

;;;; Look and Feel
;; color theme
(require 'color-theme)
(use-package color-theme-solarized
  :config
  (progn
    (set-frame-parameter nil 'background-mode 'light)
    (set-terminal-parameter nil 'background-mode 'light)
    (load-theme 'solarized t)
    ))

;; powerline
(use-package powerline
  :ensure t
  :init (powerline-default-theme)
  )

;; disable menubar mode
(menu-bar-mode 0)

;; disable toolbar mode
(tool-bar-mode 0)

;; disable scrollbar mode
(scroll-bar-mode 0)

;;; Fonts
;; ascii fonts
(set-face-attribute 'default nil
                    :family "Roboto Mono"
                    :height 100)

;; japanese-jisx0208 fonts
(set-fontset-font nil
                  'japanese-jisx0208
                  (font-spec :family "Noto Sans Mono CJK JP Bold"))
(add-to-list 'face-font-rescale-alist
             '("Noto Sans Mono CJK JP Bold" . 1.223))

;; nlinum
(use-package nlinum
  :defer
  :init (add-hook 'prog-mode-hook 'nlinum-mode)
  :config (setq nlinum-format "%5d "))
  
;;;; Company
(req-package company
  :force t
  :config
  (progn
    (setq company-idle-delay 0)
    (setq company-minimum-prefix-length 2)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "TAB") 'company-complete-selection)
    (add-hook 'prog-mode-hook 'company-mode)
    ))

;;;; helm
(use-package helm
  :defer
  :init
  (progn

    (setq helm-input-idle-delay 0.01)
    (helm-mode))
  :bind (("C-x b" . helm-buffers-list)
         ("C-x C-f" . helm-find-files)
         ("M-x" . helm-M-x))
  :config
  (progn
    (setq helm-idle-delay 0.0)
    (define-key helm-find-files-map
      (kbd "TAB") 'helm-execute-persistent-action)
    (define-key helm-buffer-map
      (kbd "TAB") 'helm-execute-persistent-action)
    (set-face-attribute 'helm-selection nil
                        :family "Roboto Mono Medium")))

;;;; Language
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; skk
(use-package skk
  :ensure ddskk
  :config
  (progn
    (global-set-key (kbd "C-x C-j") 'skk-mode)
    ))

;;;; Language Setting
;; flycheck
(use-package flycheck
  :init
  (add-hook 'prog-mode-hook #'flycheck-mode)
  )

;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)


;; Ruby

(req-package inf-ruby
  :config
  (progn
    (add-to-list 'inf-ruby-implementations '("pry" . "pry"))
    (setq inf-ruby-implementation "pry")
    ))
  
(req-package robe
  :require company
  :config (add-to-list 'company-backends 'company-robe)
  )

(provide 'init)
;;; init.el ends here
