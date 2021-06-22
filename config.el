;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Hack" :size 15 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "Hack" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;
(setq doom-theme 'doom-xcode)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; org mode
(setq org-directory "~/Documents/Org/")

(setq display-line-numbers-type 'relative)

(setq initial-frame-alist '((top . 1) (left . 1) (width . 150)(height .100))) ;; doom startup window size



;roam
(setq org-roam-directory "~/Documents/Roam" )

;; WHICH key
;; making which key pop faster
(setq which-key-idle-delay 0.5)

;deft
(setq deft-directory "~/Documents/Roam"
      deft-extensions  '("org" "txt")
      deft-recursive t)

(setq global-hl-line-mode -1) ;; doesn't work at all

(display-time-mode 1) ; Enable time in the mode-line

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t) ;; shows the buffer preview when selecting the buffer

;; (map! :map evil-window-map
;;       "spc" #'rotate-layout
;;       ;; navigation
;;       "<left>"     #'evil-window-left
;;       "<down>"     #'evil-window-down
;;       "<up>"       #'evil-window-up
;;       "<right>"    #'evil-window-right
;;       ;; swapping windows
;;       "c-<left>"       #'+evil/window-move-left
;;       "c-<down>"       #'+evil/window-move-down
;;       "c-<up>"         #'+evil/window-move-up
;;       "c-<right>"      #'+evil/window-move-right)

(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")


(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))



;; (after! company
;;   (setq company-idle-delay 0.2
;;         company-minimum-prefix-length 3)
;;   (setq company-show-numbers t)
;;   (add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.

;; better history
;; (setq-default history-length 1000)
;; (setq-default prescient-history-length 1000)

;; (setq calc-angle-mode 'rad  ; radians are rad
;;       calc-symbolic-mode t) ; keeps expressions like \sqrt{2} irrational for as long as possible

;; (set-company-backend!
;;   '(text-mode
;;     markdown-mode
;;     gfm-mode)
;;   '(:seperate
;;     company-ispell
;;     company-files
;;     company-yasnippet))
;; ;; ESS mode
;; (set-company-backend! 'ess-r-mode '(company-R-args company-R-objects company-dabbrev-code :separate))


;; ;; treemacs DON"T UNDO it
;; (after! treemacs
;;   (defvar treemacs-file-ignore-extensions '()
;;     "File extension which `treemacs-ignore-filter' will ensure are ignored")
;;   (defvar treemacs-file-ignore-globs '()
;;     "Globs which will are transformed to `treemacs-file-ignore-regexps' which `treemacs-ignore-filter' will ensure are ignored")
;;   (defvar treemacs-file-ignore-regexps '()
;;     "RegExps to be tested to ignore files, generated from `treeemacs-file-ignore-globs'")
;;   (defun treemacs-file-ignore-generate-regexps ()
;;     "Generate `treemacs-file-ignore-regexps' from `treemacs-file-ignore-globs'"
;;     (setq treemacs-file-ignore-regexps (mapcar 'dired-glob-regexp treemacs-file-ignore-globs)))
;;   (if (equal treemacs-file-ignore-globs '()) nil (treemacs-file-ignore-generate-regexps))
;;   (defun treemacs-ignore-filter (file full-path)
;;     "Ignore files specified by `treemacs-file-ignore-extensions', and `treemacs-file-ignore-regexps'"
;;     (or (member (file-name-extension file) treemacs-file-ignore-extensions)
;;         (let ((ignore-file nil))
;;           (dolist (regexp treemacs-file-ignore-regexps ignore-file)
;;             (setq ignore-file (or ignore-file (if (string-match-p regexp full-path) t nil)))))))
;;   (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-filter))


;;org mode config
;;=======================
(setq org-startup-folded t) ;; on startup fold the heading by default

(use-package org-bullets
  :ensure t
  :config
  (add-hook `org-mode-hook (lambda () (org-bullets-mode 1))))

;;---------------------------------------------------------------
;; org mode config :: ZZAMBONI config
(setq org-hide-emphasis-markers t) ; hide org mode emphasis markers like * / and other
; math equation in org mode
(setq org-pretty-entitles t)
(setq org-export-with-latex t)
(setq org-format-latex-options '(:foreground "White"))
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.0)) ;; setting the scale of latex in preview mode


;; font lock subsitution for list markers by replacing them with a centered dot
(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; ;; proportional font in different sizes, for the headlines.
 (let* ((variable-tuple
          (cond ((x-list-fonts "Hack")         '(:font "Hack"))
                ((x-list-fonts "Source Code Pro") '(:font "Source Code Pro"))
                ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                ((x-list-fonts "Verdana")         '(:font "Verdana"))
                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro. ERROR : org mode config key word to search : variable-tuple"))))
         (base-font-color     (face-foreground 'default nil 'default))
         (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

;; ;; ;; setting  up variable pitch and fixed pitch faces

;; making highlight bright red
(add-to-list 'org-emphasis-alist
             '("*" (:foreground "red")
               ))
