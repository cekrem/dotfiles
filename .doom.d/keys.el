;;; keys.el -*- lexical-binding: t; -*-

;; [] prefix hack part 1/12 (leave on top!)
(map! :n
      "]" nil
      "[" nil
      )

;; Leader key: \
(map! :m "\\" nil)
(setq doom-leader-key "\\")

;; General shortcuts (TODO: create sections if this gets large)
(map! :leader
      "r e" 'restart-emacs
      "t t" 'vterm
      "b" 'helm-buffers-list
      "M-p" 'helm-show-kill-ring
      "g" 'magit)

;; Window management
(map! :g
      "C-M-h" 'evil-window-left
      "C-M-j" 'evil-window-down
      "C-M-k" 'evil-window-up
      "C-M-l" 'evil-window-right)
(map! :leader
      "f f" 'toggle-frame-fullscreen
      "m m" 'toggle-frame-maximized
      ". s" (lambda() (interactive)(switch-to-buffer "*scratch*"))
      "v v" 'evil-window-vsplit
      "s s" evil-normal-state-map "ss" 'evil-window-split
      "b" 'helm-buffers-list)

;; Org
(map! :g
      "C-c l" 'org-link
      "C-c a" 'org-agenda
      "C-c c" 'org-capture)

;; File shortcuts
(map! :leader
      ". t" (lambda() (interactive)(find-file "~/Dropbox/org/main.org"))
      ". v" (lambda() (interactive)(find-file "~/Dropbox/org/vipps.org"))
      ". i" (lambda() (interactive)(find-file "~/.doom.d/init.el"))
      ". e" (lambda() (interactive)(find-file "~/.doom.d/config.el"))
      ". k" (lambda() (interactive)(find-file "~/.doom.d/keys.el"))
      ". p" (lambda() (interactive)(find-file "~/.doom.d/packages.el"))
      )

;; Autocomplete
(map! :map company-active-map
      "C-n" 'company-select-next
      "C-p" 'company-select-previous)

;; LSP / IntelliSense
(map! :leader
      "r r" 'lsp-rename
      "f r" 'lsp-find-references
      "v" 'lsp-ui-doc-glance
      "p" '+format/region-or-buffer
      )


(map! :n
      "] w" 'flycheck-next-error
      "[ w" 'flycheck-previous-error
      )

;; Improve go to definition behavior
(map! :m "C-]" '+lookup/definition)

;; Find/search/projects
(map! :n "C-p" nil)
(map! :g "C-p" '+helm/projectile-find-file
      "C-SPC" 'helm-projectile-switch-project)
(map! :leader
      "w n" '+workspace/new
      "w r" '+workspace/rename
      "a" '+helm/project-search
      "o" 'helm-find-files)

;; [] prefix hack part 2/2 (leave on bottom!)
(map! :i
      "]" 'self-insert-command
      "[" 'self-insert-command
      )
