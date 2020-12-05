(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(eval-when-compile
  (require 'use-package))

;;project management-ish related packages
(use-package treemacs :ensure t)
(use-package treemacs-all-the-icons :ensure t)
(use-package treemacs-magit :ensure t)
(use-package treemacs-projectile :ensure t)
(use-package deadgrep :ensure t)
(use-package sudo-edit :ensure t)
(use-package ripgrep :ensure t)
(use-package helm
  :ensure t
  :config
    (helm-mode 1)
  :bind (:map helm-map
              ("C-j" . helm-next-line)
              ("C-k" . helm-previous-line)))
(use-package projectile
  :ensure t
  :config
    (projectile-mode +1)
    (setq projectile-indexing-method 'alien)
    (setq projectile-enable-caching nil)
    (setq projectile-git-command "fd . -0")

    :bind (:map projectile-mode-map
                ("C-c p" . projectile-command-map)))


;;ui related packages
(use-package all-the-icons :ensure t)
(use-package which-key
  :ensure t
  :config
    (which-key-mode))
(use-package spaceline
  :ensure t
  :config
    (require 'spaceline-config)
    (setq spaceline-buffer-encoding-abbrev-p nil)
    (setq spaceline-line-column-p nil)
    (setq spaceline-line-p nil)
    (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
    (setq powerline-default-separator (quote arrow))
    (spaceline-spacemacs-theme))

;;application-like packages
(use-package vterm :ensure t)
(use-package dmenu
  :ensure t)

(use-package dashboard
  :ensure t
  :config
    (setq dashboard-items '((projects . 5)
                            (recents . 5)
                            (agenda . 5)
                            ))
    (dashboard-setup-startup-hook))


(use-package nov
  :ensure t
  :config
    (setq nov-text-width 80)
    (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(use-package persistent-scratch
  :ensure t
  :config
    (persistent-scratch-autosave-mode 1))

(use-package helm-pass :ensure t)

(use-package eshell-z
  :ensure t
  :config
    (add-hook 'eshell-mode-hook
          (defun my-eshell-mode-hook ()
            (require 'eshell-z))))

(use-package eshell-git-prompt
  :ensure t
  :config
    (eshell-git-prompt-use-theme 'powerline))

(use-package eshell-toggle
  :ensure t
  :custom
    (eshell-toggle-size-fraction 3)
    (eshell-toggle-use-projectile-root t)
    (eshell-toggle-run-command nil)
    (eshell-toggle-init-function #'eshell-toggle-init-eshell))

(use-package undo-tree :ensure t
  :config
    (global-undo-tree-mode 1))

(use-package org-journal :ensure t)

(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "/home/jbrechtel/sync/kb"))

;;    :bind (:map org-roam-mode-map
;;            (("C-c n l" . org-roam)
;;             ("C-c n f" . org-roam-find-file)
;;             ("C-c n g" . org-roam-graph))
;;            :map org-mode-map
;;            (("C-c n i" . org-roam-insert))
;;            (("C-c n I" . org-roam-insert-immediate))))


;;evil stuff
(use-package evil
  :ensure t
  :config
    (setq evil-want-keybinding nil)
    (global-evil-leader-mode)
    (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package treemacs-evil :ensure t)
(use-package evil-leader :ensure t)
(use-package evil-magit :ensure t)

;;git stuff
(use-package magit :ensure t)
(use-package forge :ensure t)

;;language support
(use-package haskell-mode :ensure t)
(use-package purescript-mode
  :ensure t
  :config
    (add-hook 'purescript-mode-hook 'turn-on-purescript-indent))
(use-package elm-mode :ensure t)
(use-package yaml-mode :ensure t)

;;exwm
(use-package exwm
  :ensure t
  :init
    ;; kick all exwm buffers into insert mode per default
    (add-hook 'exwm-manage-finish-hook 'exwm/enter-insert-state)

  :config
    (require 'exwm-randr)
    (require 'exwm-config)
    (setq exwm-randr-workspace-output-plist '(0 "DP-4" 1 "DP-2"))
    (exwm-randr-enable)
    (setq exwm-workspace-number 10)
    (require 'exwm-systemtray)
    (exwm-systemtray-enable)

;;  (setq exwm-workspace-show-all-buffers t)
    (setq exwm-layout-show-all-buffers t)

    ;;; Rename buffer to window title.
    (defun exwm-rename-buffer-to-title () (exwm-workspace-rename-buffer exwm-title))
    (add-hook 'exwm-update-title-hook 'exwm-rename-buffer-to-title)

    ;;exwm keys
    (define-key exwm-mode-map (kbd "C-c") nil)
    (define-key exwm-mode-map (kbd "C-x") nil)

    (exwm-input-set-key (kbd "s-<tab>") #'treemacs-find-file)
    (exwm-input-set-key (kbd "s-b") #'helm-buffers-list)
    (exwm-input-set-key (kbd "s-d") #'dmenu)

    (exwm-input-set-key (kbd "s-f") #'exwm-layout-toggle-fullscreen)
    (exwm-input-set-key (kbd "s-h") #'windmove-left)
    (exwm-input-set-key (kbd "s-j") #'windmove-down)
    (exwm-input-set-key (kbd "s-k") #'windmove-up)
    (exwm-input-set-key (kbd "s-l") #'windmove-right)
    (exwm-input-set-key (kbd "s-m") #'maximize-window)
    (exwm-input-set-key (kbd "s-,") #'balance-windows)

    (exwm-input-set-key (kbd "s-r") #'exwm-reset)

    (exwm-input-set-key (kbd "s-e") #'helm-exwm)
    (exwm-input-set-key (kbd "s-p") #'helm-pass)
    (exwm-input-set-key (kbd "s-n") #'org-roam-find-file)
    (exwm-input-set-key (kbd "s-t") #'eshell-toggle)
    (exwm-input-set-key (kbd "C-s-t") #'org-agenda)
    (exwm-input-set-key (kbd "s-x") (lambda () (interactive) (switch-to-buffer "*scratch*")))

    (exwm-input-set-key (kbd "s-1") (lambda () (interactive) (exwm-workspace-switch 0)))
    (exwm-input-set-key (kbd "s-2") (lambda () (interactive) (exwm-workspace-switch 1)))
    (exwm-input-set-key (kbd "s-3") (lambda () (interactive) (exwm-workspace-switch 2)))
    (exwm-input-set-key (kbd "s-4") (lambda () (interactive) (exwm-workspace-switch 4)))
    (exwm-input-set-key (kbd "s-5") (lambda () (interactive) (exwm-workspace-switch 5)))
    (exwm-input-set-key (kbd "s-6") (lambda () (interactive) (exwm-workspace-switch 6)))
    (exwm-input-set-key (kbd "s-7") (lambda () (interactive) (exwm-workspace-switch 7)))
    (exwm-input-set-key (kbd "s-8") (lambda () (interactive) (exwm-workspace-switch 8)))
    (exwm-input-set-key (kbd "s-9") (lambda () (interactive) (exwm-workspace-switch 9)))
    (exwm-input-set-key (kbd "s-0") (lambda () (interactive) (exwm-workspace-switch 10)))

    ;;(add-hook 'exwm-init-hook exwm-custom-init t)

    ;; Simulate normal state by using line mode with passthrough, i.e. forward all commands to emacs
    (defun exwm/enter-normal-state ()
      (interactive)
      (setq exwm-input-line-mode-passthrough t)
      (call-interactively 'exwm-input-grab-keyboard)
      (evil-normal-state))
    ;; Simulate insert state by using line mode without passthrough
    (defun exwm/enter-insert-state ()
      (interactive)
      (setq exwm-input-line-mode-passthrough nil)
      (call-interactively 'exwm-input-grab-keyboard)
      (evil-insert-state))

    ;; in normal state/line mode, use the familiar i key to switch to input state
    ;; (evil-define-key 'normal exwm-mode-map (kbd "i") 'exwm-input-release-keyboard)
    (evil-define-key 'normal exwm-mode-map (kbd "i") 'exwm/enter-insert-state)
    (dolist (k '("<down-mouse-1>" "<down-mouse-2>" "<down-mouse-3>"))
      (evil-define-key 'normal exwm-mode-map (kbd k) 'exwm/enter-insert-state))

    (exwm-input-set-key (kbd "s-<escape>") #'exwm/enter-normal-state))

(use-package helm-exwm :ensure t)

;; Keys
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "<SPC>" 'helm-M-x
  "b b" 'helm-buffers-list
  "b n" 'next-buffer
  "b p" 'previous-buffer
  "b d" 'evil-delete-buffer
  "g g" 'magit-status
  "f f" 'helm-find-files
  "p f" 'projectile-find-file
  "p p" 'counsel-projectile-switch-project
  "f s" 'save-buffer
  "w k" 'evil-window-up
  "w j" 'evil-window-down
  "w h" 'evil-window-left
  "w l" 'evil-window-right
  "w v" 'split-window-right
  "w s" 'split-window-below
  "w c" 'delete-window
  "w d" 'delete-window
  "e p" 'helm-pass
  "s p" 'deadgrep)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face 'default)
 '(custom-safe-themes
   '("0cd00c17f9c1f408343ac77237efca1e4e335b84406e05221126a6ee7da28971" "f126f3b6ca7172a4a2c44186d57e86a989c2c196d0855db816a161bf857b58fb" default))
 '(evil-undo-system 'undo-tree)
 '(fci-rule-color "#323342")
 '(helm-minibuffer-history-key "M-p")
 '(highlight-changes-colors '("#ff8eff" "#ab7eff"))
 '(highlight-tail-colors
   '(("#323342" . 0)
     ("#63de5d" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#323342" . 100)))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   '(org-journal evil-collection deadgrep face-explorer nov persistent-scratch eshell-toggle eshell-git-prompt eshell-z helm-descbinds sudo-edit org-roam treemacs-projectile treemacs-magit treemacs-evil treemacs-all-the-icons treemacs evil-owl evil-org undo-tree forge magit-gh-pulls evil-magit darkokai-theme helm-exwm ivy-historian historian vterm use-package))
 '(pos-tip-background-color "#E6DB74")
 '(pos-tip-foreground-color "#242728")
 '(purescript-mode-hook
   '(turn-on-purescript-indent turn-on-purescript-indentation turn-on-purescript-simple-indent))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#ff0066")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#63de5d")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#53f2dc")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#06d8ff")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#242728" "#323342" "#F70057" "#ff0066" "#86C30D" "#63de5d" "#BEB244" "#E6DB74" "#40CAE4" "#06d8ff" "#FF61FF" "#ff8eff" "#00b2ac" "#53f2dc" "#f8fbfc" "#ffffff")))

;;UI preferences
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)
(load-theme 'dichromacy)
(set-face-attribute 'default nil :font "Nova Mono" :height 130)
(setq inhibit-start-message t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(variable-pitch ((t (:height 1.2 :family "Noto Sans")))))


(setq org-directory "/home/jbrechtel/sync/kb")
(setq org-agenda-files '("/home/jbrechtel/sync/kb"
			 "/home/jbrechtel/sync/kb/journal"
			 "/home/jbrechtel/sync/kb/drafts"
			 "/home/jbrechtel/sync/kb/notes"
			 "/home/jbrechtel/sync/kb/books"))

(dashboard-refresh-buffer)
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
