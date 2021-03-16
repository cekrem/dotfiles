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
(setq custom-file "~/.emacs.d/custom.el")
(load-file custom-file)
(tool-bar-mode -1)
;;(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(setq initial-buffer-choice "~/Dropbox/org/main.org")
(global-display-line-numbers-mode)
(setq x-select-enable-clipboard t)

;; Don't leave backup files all over the place
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Mac specific settings
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)
(setq mac-command-modifier 'meta)

(when (equal system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (when (member "JetBrains Mono" (font-family-list))
    (add-to-list 'initial-frame-alist '(font . "JetBrains Mono-14"))
    (add-to-list 'default-frame-alist '(font . "JetBrains Mono-14")))
  (set-fontset-font t 'symbol (font-spec :family "Apple Symbols") nil 'prepend)
  (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend))

(when (featurep 'ns)
  (defun ns-raise-emacs ()
    "Raise Emacs."
    (ns-do-applescript "tell application \"Emacs\" to activate"))(defun ns-raise-emacs-with-frame (frame)
    "Raise Emacs and select the provided frame."
    (with-selected-frame frame
      (when (display-graphic-p)
        (ns-raise-emacs))))(add-hook 'after-make-frame-functions 'ns-raise-emacs-with-frame)(when (display-graphic-p)
    (ns-raise-emacs)))

;; Reuse help window
(setq display-buffer-alist
      `((,(rx bos (or "*Apropos*" "*Help*" "*helpful" "*info*" "*Summary*") (0+ not-newline))
         (display-buffer-reuse-mode-window display-buffer-below-selected)
         (window-height . 0.33)
         (mode apropos-mode help-mode helpful-mode Info-mode Man-mode))))

;; Require and initialize `package`.
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

;; Setup `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Themes and appearance
(load-theme 'gruvbox t)

;; Restart emacs
(use-package restart-emacs
  :ensure t)

;; Http requests
(use-package request
  :ensure t)

;; Key overrides simplified
(use-package bind-key
  :ensure t
  :config
  (bind-key* "C-a" 'treemacs)
  (bind-key* "C-SPC" 'helm-projectile-switch-project)
  (bind-key* "Q" 'delete-other-windows)
  (bind-key* "C-c l" 'org-link)
  (bind-key* "C-c a" 'org-agenda)
  (bind-key* "C-c c" 'org-capture)

  (global-set-key (kbd "<C-tab>") 'switch-to-next-buffer)
  (global-set-key (kbd "<C-S-tab>") 'switch-to-prev-buffer)
  )

;; Shell env
(defun set-path-from-file (filePath)
  "Set up Emacs' `exec-path` and `PATH` env var to match content of filePath."
  (interactive)
  (let ((path-from-file (with-temp-buffer
                          (insert-file-contents filePath)
                          (buffer-string)
                          )
                        ))
    (setenv "PATH" path-from-file)
    (setq exec-path (split-string path-from-file path-separator))))

(set-path-from-file "~/path")

;; Evil mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (define-key evil-motion-state-map (kbd "H") nil)
  (define-key evil-motion-state-map (kbd "J") nil)
  (define-key evil-motion-state-map (kbd "K") nil)
  (define-key evil-motion-state-map (kbd "L") nil)
  (evil-set-undo-system 'undo-tree)
  (evil-mode 1))

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

    "h" 'evil-window-left
    "j" 'evil-window-down
    "k" 'evil-window-up
    "l" 'evil-window-right

    "r e" 'restart-emacs
    "x" 'helm-M-x
    "b" 'helm-buffers-list
    "t t" 'eshell
    "g" 'magit
    "a" 'helm-projectile-rg
    "o" 'helm-find-files
    "q" 'delete-all-overlays
    "p" (lambda ()
          (interactive)
          (if (bound-and-true-p lsp-mode)
              (lsp-format-buffer)
            (format-all-ensure-formatter)
            (format-all-buffer)
            )
          )
    "n" (lambda()
          (interactive)
          (elfeed-update)
          (elfeed)
          )

    ;; Intellisense leader shortcuts
    "r r" 'lsp-rename
    "f r" 'lsp-find-references
    "v" 'helm-lsp-code-actions

    ". j" 'find-journal
    ". t" (lambda() (interactive)(find-file "~/Dropbox/org/main.org"))
    ". s" (lambda() (interactive)(switch-to-buffer "*scratch*"))
    ". e" (lambda() (interactive)(find-file "~/.emacs"))))

(use-package evil-indent-textobject
  :ensure t)

(use-package evil-matchit
  :ensure t)

(use-package powerline-evil
  :ensure t
  :config
  (powerline-evil-vim-color-theme))

(use-package key-chord
  :ensure t
  :config
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
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
  (setq projectile-project-search-path '("~/code" "~/Dropbox")))

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
(defvar journal-dir
  (expand-file-name"~/Dropbox/org/journals/"))

(defvar journal
  (format "%sjournal%s.org"
	  journal-dir
	  (format-time-string "%Y%m%d")))

(defvar org-journal-template
  (concat
   "#+TITLE: Journal\n"
   "#+DATE: " (format-time-string "%A %d/%m/%Y\n")
   "* TODAY\n"
   "* NOTES"))

(defun find-journal (days-ago)
  "Find journal from DAYS-AGO"
  (interactive "p")
  (if (not current-prefix-arg)
      (find-file
       journal)
    (find-file
     (concat
      journal-dir
      "journal"
      (format-time-string
       "%Y%m%d"
       (seconds-to-time (- (time-to-seconds) (* days-ago 86400))))
      ".org"))))

(use-package org
  :ensure org-plus-contrib
  :mode (("\\.org$" . org-mode))
  :config

  ;; default export options
  (setq org-export-with-section-numbers nil)
  (setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://gongzhitaao.org/orgcss/org.css\" />")
  (setq org-html-validation-link nil)

  ;; set agenda files
  (setq org-agenda-files '("~/Dropbox/org"))

  ;; customize todo states
  (setq org-todo-keywords
        '((sequence "TODO" "IN-PROGRESS" "IN-REVIEW" "BLOCKED" "LATER" "DONE")))

  ;; customize default tags
  (setq org-tag-alist '(
                        ("@AndroidCore" .?c)
                        ("@eCom" .?e)
                        ("@SPAE" .?s)
                        ("@OrgChore" .?r)
                        ("@HouseChore" .?h)
                        ("@Learn" .?l)
                        ("@Family" .?f)
                        ("@Personal" .?p)
                        ("@Workout" .?w)
                        ))

  ;; customize capture
  (setq org-default-notes-file "~/Dropbox/org/ideas.org")
  (setq org-capture-templates
	'(
          ("i" "Idea" entry (file+headline "~/Dropbox/org/ideas.org" "Ideas")
	   "** %?\n")

          ("t" "Todo" entry (file+headline journal "Today")
	   "** TODO %?\n")
	  ("n" "Note" entry (file+headline journal "Notes")
	   "** %?\n\n")
          ))

  ;; customize targets for archive/refile
  (setq org-archive-location "~/Dropbox/org/archived.org::* From %s")
  (setq org-refile-targets
        '(
          (("~/Dropbox/org/main.org") :maxlevel . 3)
          (("~/Dropbox/org/backlog.org") :maxlevel . 3)
          )))

(use-package evil-org
  :ensure t
  :after (org evil)
  :hook (org-mode . evil-org-mode)
  :init
  :config
  (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading calendar))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package verb
  :ensure t
  :after org
  :config
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

;; Helm
(use-package helm
  :ensure t
  :init
  (require 'helm-config)
  :config
  (helm-mode 1)
  (global-set-key (kbd "M-x") 'helm-M-x)  ;; Improved M-x menu
  (global-set-key (kbd "M-p") 'helm-show-kill-ring)  ;; Paste history
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

(use-package suggest
  :ensure t)

(use-package evil-paredit
  :ensure t
  :hook
  (emacs-lisp-mode . evil-paredit-mode)
  (emacs-lisp-mode . paredit-mode))

(use-package eros
  :ensure t
  :hook
  (emacs-lisp-mode . eros-mode))

;; IntelliSense stuff and languages
(use-package format-all
  :ensure t)

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
  ((go-mode kotlin-mode web-mode) . lsp)
  (before-save . lsp-format-buffer)
  (before-save . lsp-organize-imports))

(use-package lsp-ui
  :ensure t
  :hook
  ((lsp-mode . lsp-ui-mode)))

(use-package lsp-treemacs
  :ensure t)

(use-package web-mode
  :mode (("\\.js$" . web-mode))
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package go-mode
  :ensure t)

(use-package flycheck-golangci-lint
  :after go-mode flycheck
  :ensure t
  :hook (go-mode . flycheck-golangci-lint-setup))

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
(use-package rainbow-delimiters
  :ensure t
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(provide '.emacs)
;;; .emacs ends here
