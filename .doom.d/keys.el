;;; keys.el -*- lexical-binding: t; -*-

;; Leader key: \
(map! :m "\\" nil)
(setq doom-leader-key "\\")

;; General shortcuts (TODO: create sections if this gets large)
(map! :leader
      "r e" 'restart-emacs
      "t t" 'vterm
      "g" 'magit)
(map! :g
      "M-p" '+default/yank-pop)

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
      "b" '+ivy/switch-buffer)

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

;; Autocomplete next/prev
(map! :map company-active-map
      "C-n" 'company-select-next
      "C-p" 'company-select-previous)

(map! :map ivy-mode-map
      "C-n" 'ivy-next-line
      "C-p" 'ivy-previous-line)

;; LSP / IntelliSense
(map! :leader
      "r r" 'lsp-rename
      "f r" 'lsp-find-references
      "v" 'lsp-ui-doc-glance
      "p" '+format/region-or-buffer
      "e" 'flycheck-list-errors
      )
(map! :g
      "M-RET" 'lsp-ui-sideline-apply-code-actions)

;; Improve go to definition behavior
(map! :m "C-]" '+lookup/definition)

;; Find/search/projects
(map! :n "C-p" '+ivy/projectile-find-file
      "C-SPC" 'projectile-switch-project)
(map! :leader
      "w n" '+workspace/new
      "w r" '+workspace/rename
      "w s" '+workspace/save
      "w l" '+workspace/load
      "a" '+ivy/project-search
      "o" '+default/find-file-under-here)
