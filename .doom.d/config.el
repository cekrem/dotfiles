;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Christian Ekrem"
      user-mail-address "christianekrem@gmail.com")
(setq frame-title-format "%b - cekrem Emacs")

;; Tweaks undeserving of their own file (for now)
(setq display-line-numbers-type t)
(setq initial-major-mode 'lisp-interaction-mode)
(global-display-fill-column-indicator-mode +1)
(setq doom-theme 'doom-one-light)

(setq lsp-ui-doc-enable nil)
(setq lsp-intelephense-multi-root nil)
(setq lsp-solargraph-multi-root nil)
(setq lsp-headerline-breadcrumb-enable 1)

(add-to-list 'company-backends 'company-files)
(ispell-change-dictionary "american" t)
(hl-line-mode -1)
(setq projectile-project-search-path '("~/code" "~/Dropbox"))

(setq scroll-conservatively 0)
(setq scroll-step 10)

;; Mac customization
(when (equal system-type 'darwin)
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-key-is-meta nil)
  (setq mac-option-modifier 'none)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

(load! "./org.el")
(load! "./keys.el")

;; disable "everything" while scrolling
(load! "./fast-scroll.el")
