;; Add melpa package manager source
;; https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Remove toolbar, munbar and make cursor I instead of block
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq-default cursor-type 'bar) 

;; Change theme to thango-dark
;; M-x customize-themes
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(package-selected-packages
   '(elfeed company dashboard org-bullets switch-window ido-vertical-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Don't make backup files
(setq make-backup-files nil)

;; ido enabling
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)
(use-package ido-vertical-mode
  :ensure t
  :init	(ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x b") 'ibuffer)
(setq ibuffer-expert t)

;; Don't make beep sound
(set-message-beep 'silent)

;; C-c e to visit init.el
;; C-c r to load init.el
(defun config-visit()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-c e") 'config-visit)
(defun config-reload()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c r") 'config-reload)

;; Better window management
(use-package switch-window :ensure t)
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "C-x 1") 'switch-window-then-maximize)
(global-set-key (kbd "C-x 2") 'switch-window-then-split-below)
(global-set-key (kbd "C-x 3") 'switch-window-then-split-right)
(global-set-key (kbd "C-x 0") 'switch-window-then-delete)
(global-set-key (kbd "C-x 4 d") 'switch-window-then-dired)
(global-set-key (kbd "C-x 4 f") 'switch-window-then-find-file)
(global-set-key (kbd "C-x 4 m") 'switch-window-then-compose-mail)
(global-set-key (kbd "C-x 4 r") 'switch-window-then-find-file-read-only)
(global-set-key (kbd "C-x 4 C-f") 'switch-window-then-find-file)
(global-set-key (kbd "C-x 4 C-o") 'switch-window-then-display-buffer)
(global-set-key (kbd "C-x 4 0") 'switch-window-then-kill-buffer)

;; Show line numbers
(global-display-line-numbers-mode 1)

;; Improve org-mode bullets, don't show asterisks
(use-package org-bullets 
:ensure t 
:hook((org-mode) . org-bullets-mode))

;; Use a better startup screen
(setq inhibit-startup-message t)
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-items '((recents   . 10)
                        (bookmarks . 5)
                        (projects  . 5)
                        (agenda    . 10)
                        (registers . 5)))
(setq dashboard-week-agenda t)

;; auto-completion
(use-package company
  :ensure t
  :init
  (add-hook ' after-init-hook 'global-company-mode))

;; press RET in order to follow links in org-mode
(setq org-return-follows-link  t)

;; Add RSS to Emacs
(use-package elfeed
  :ensure t
  :init (elfeed-update))
(global-set-key (kbd "C-x w") 'elfeed)
(setq elfeed-feeds
      '(("https://www.informador.mx/rss/jalisco.xml" Informador)
	("https://www.informador.mx/rss/mexico.xml" Informador)
	("http://www.npr.org/rss/rss.php?id=1001" NPR)
	("https://stallman.org/rss/rss.xml" Stallman)
	("https://protesilaos.com/master.xml" Protesilaos)
	("https://hnrss.org/frontpage" HN)
	("https://notxor.nueva-actitud.org/rss.xml" Noxtor)))

;; Jump line if line is too long in org-mode
(add-hook 'org-mode-hook #'(lambda () (setq fill-column 80)))
(add-hook 'org-mode-hook 'turn-on-auto-fill)
