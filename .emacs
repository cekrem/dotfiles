;; .emacs -- My Emacs configuration
;-*-Emacs-Lisp-*-

;;; Commentary:
;;
;; :D
;;
;;; Code:

;; Utf-8
(setq-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq locale-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;; Startup
(setq initial-buffer-choice "~/index.org")

;; Basic settings
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indicate-empty-lines t)
(setq-default indent-tabs-mode nil)
(setq visible-bell t)
(setq vc-follow-symlinks t)
(setq large-file-warning-threshold nil)
(setq split-width-threshold nil)
(setq custom-safe-themes t)
(column-number-mode t)
(setq tab-width 4)
(setq tramp-default-method "ssh")
(setq tramp-syntax 'simplified)
(global-hl-line-mode t)
(setq mac-command-modifier 'meta)
(setq custom-file "~/.emacs.d/custom.el")
(load-file custom-file)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(global-display-line-numbers-mode)

;; Require and initialize `package`.
(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)

;; Setup `use-package`
(unless (package-installed-p 'use-package)
        (package-refresh-contents)
        (package-install 'use-package))

(eval-when-compile
 (require 'use-package))

;; Theme
(load-theme 'gruvbox t)

;; Key overrides simplified
(use-package bind-key
  :ensure t
  :config
  (bind-key* "C-a" 'treemacs)
  (bind-key* "C-SPC" 'helm-projectile-switch-project)
  (bind-key* "J" 'evil-window-down)
  )

;; Shell env
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; Evil mode
(use-package evil
             :ensure t
             :init
             (setq evil-want-keybinding nil)
             :config
             (evil-set-undo-system 'undo-tree)
             (evil-mode 1)
             (define-key evil-normal-state-map (kbd "H") 'evil-window-left)
             (define-key evil-motion-state-map (kbd "J") 'evil-window-down)
             (define-key evil-normal-state-map (kbd "J") 'evil-window-down)
             (define-key evil-normal-state-map (kbd "K") 'evil-window-up)
             (define-key evil-normal-state-map (kbd "L") 'evil-window-right))

(use-package evil-collection
  :ensure t
  :after evil
  :custom
  (evil-collection-company-use-tng nil)
  :init
  (evil-collection-init))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))

(use-package evil-leader
             :ensure t
             :after evil
             :config
             (define-key evil-motion-state-map (kbd "\\") nil)
             (global-evil-leader-mode t)
             (evil-leader/set-leader "\\")
             (evil-leader/set-key
               "x" 'helm-M-x
               "b" 'helm-buffers-list
               "t t" 'shell
               "g" 'magit
               "a" 'helm-projectile-rg
               "o" 'helm-find-files
               "q" 'delete-all-overlays
               "p" 'indent-region
               "n" (lambda()
                     (interactive)
                     (elfeed-update)
                     (elfeed)
                     )

               ;; Intellisense leader shortcuts
               "r r" 'lsp-rename
               "f r" 'lsp-find-references

               ". e" (lambda() (interactive)(find-file "~/.emacs"))))

(use-package evil-indent-textobject
             :ensure t)

(use-package evil-matchit
             :ensure t)

(use-package evil-org
  :ensure t
  :after (evil org)
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme '(navigation insert textobjects additional calendar))))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package powerline-evil
             :ensure t
             :config
             (powerline-evil-vim-color-theme))

(use-package key-chord
             :ensure t
             :config
             (setq key-chord-two-keys-delay 0.5)
             (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
             (key-chord-define evil-normal-state-map "xx" 'delete-other-windows)
             (key-chord-define evil-normal-state-map "qq" 'delete-other-windows)
             (key-chord-define evil-normal-state-map "]w" 'flycheck-next-error)
             (key-chord-define evil-normal-state-map "[w" 'flycheck-previous-error)
             (key-chord-define evil-normal-state-map "vv" 'evil-window-vsplit)
             (key-chord-define evil-normal-state-map "ss" 'evil-window-split)
             (key-chord-define evil-normal-state-map "ff" 'toggle-frame-fullscreen)
             (key-chord-define evil-normal-state-map "mm" 'toggle-frame-maximized)
             (key-chord-mode 1))

;; Feed/news
(use-package elfeed
  :ensure t
  :init
  (setq elfeed-feeds
   '(
     ;;dev.to
     ("http://dev.to/feed" dev)

     ;;reddit
     ("http://reddit.com/r/emacs/.rss" dev)
     ("http://reddit.com/r/golang/.rss" dev)
     ("http://reddit.com/r/kotlin/.rss" dev)

     ;;hackernews
     ("https://news.ycombinator.com/rss" news)
     )))

;; Navigation
(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/code")))

(use-package treemacs
  :ensure t
  :defer t
  :config)

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :ensure t
  :after treemacs projectile)

;; Org-mode
(use-package org
  :mode (("\\.org$" . org-mode))
  :ensure org-plus-contrib)

;; Helm
(use-package helm
             :ensure t
             :init
             (require 'helm-config)
             :config
             (helm-mode 1)
             (global-set-key (kbd "M-x") 'helm-M-x)  ;; Improved M-x menu
             (define-key helm-map (kbd "ESC") 'helm-keyboard-quit)
             
             (use-package helm-projectile
                          :config
                          (projectile-mode)
                          (setq projectile-completion-system 'helm)
                          (helm-projectile-on)
                          (setq projectile-enable-caching t)
                          (define-key evil-normal-state-map
                            (kbd "C-p")
                            'helm-projectile-find-file))
             (use-package helm-company
               :ensure t)
             (use-package helm-lsp
               :ensure t)
             (use-package helm-rg
               :ensure t))

;; Git
(use-package magit
  :ensure t)

;; Autocomplete
(use-package company
  :ensure t
  :defer 2
  :config
  (setq company-idle-delay 0.4)
  (setq company-selection-wrap-around t)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (global-company-mode))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; Lisp
(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "/usr/local/bin/ros run"))

(use-package evil-paredit
  :ensure t
  :hook
  (emacs-lisp-mode-hook . evil-paredit-mode)
  (emacs-lisp-mode-hook . paredit-mode))

(use-package eros
  :ensure t
  :hook
  (eros-mode . emacs-lisp-mode))

;; IntelliSense stuff
(use-package flycheck
  :ensure t
  :config
  (flycheck-mode))

(use-package lsp-mode
  :ensure t
  :after flycheck
  :commands (lsp lsp-deferred)
  :config
  ;; use flycheck, not flymake
  (setq lsp-prefer-flymake nil)
  :hook
  ((go-mode kotlin-mode) . lsp)
  (before-save . lsp-format-buffer)
  (before-save . lsp-organize-imports))

(use-package lsp-treemacs
  :ensure t)

(use-package go-mode
  :ensure t)

(use-package kotlin-mode
  :ensure t)

;; Explain keys
(use-package which-key
  :config
    (setq which-key-idle-delay 0.3)
    (setq which-key-popup-type 'frame)
    (which-key-mode)
    (which-key-setup-minibuffer)
    (set-face-attribute 'which-key-local-map-description-face nil
       :weight 'bold)
  :ensure t)

;; Colored parentheses
(use-package rainbow-mode
  :ensure t
  :after evil
  :config
  (rainbow-mode))

(provide '.emacs)
;;; .emacs ends here
