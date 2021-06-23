;;; org.el -*- lexical-binding: t; -*-

;; Org mode setup

;; default org clocktable properties
(setq org-clock-clocktable-default-properties '(:maxlevel 2 :compact t :block today :scope file))

;; default export options
(setq org-export-with-section-numbers nil)
(setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://gongzhitaao.org/orgcss/org.css\" />")
(setq org-html-validation-link nil)

;; Directories
(setq org-directory "~/Dropbox/org")
(setq org-agenda-files '("~/Dropbox/org"))

;; Journal setup
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

(after! evil-org
  (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading calendar))
  )

(after! org
  ;; customize todo states
  (setq org-todo-keywords
        '((sequence "TODO" "IN-PROGRESS" "IN-REVIEW" "BLOCKED" "LATER" "|" "DONE" "DELEGATED" "CLOSED")))

  ;; customize default tags
  (setq org-tag-alist '(
                        ("@Workweek" .?w)
                        ("@AndroidCore" .?c)
                        ("@eCom" .?e)
                        ("@SPAE" .?s)
                        ("@OrgChore" .?r)
                        ("@HouseChore" .?H)
                        ("@Learn" .?l)
                        ("@Family" .?f)
                        ("@Personal" .?p)
                        ("@Workout" .?W)
                        ))
  )

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
        ))
