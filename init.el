;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("810ab30a73c460f5c49ede85d1b9af3429ff2dff652534518fa1de7adc83d0f6" "d507c9e58cb0eb8508e15c8fedc2d4e0b119123fab0546c5fd30cadd3705ac86" "bc40f613df8e0d8f31c5eb3380b61f587e1b5bc439212e03d4ea44b26b4f408a" "365d9553de0e0d658af60cff7b8f891ca185a2d7ba3fc6d29aadba69f5194c7f" "b81bfd85aed18e4341dbf4d461ed42d75ec78820a60ce86730fc17fc949389b2" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(package-selected-packages
   (quote
    (neotree xclip dockerfile-mode evil-tabs company xterm-frobs powerline all-the-icons evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Requiers
(require 'evil)
(require 'naquadah-theme)
(require 'yaml-mode)
(require 'powerline)
(require 'neotree)
(require 'evil-leader)
(require 'xclip)

;; Theme
(load-theme 'naquadah)

;; Basic settings
(evil-mode 1)
(menu-bar-mode -1)
(setq linum-format "%3d\u2502 ") ;; Line numbers
(setq-default indent-tabs-mode nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(set-buffer-modified-p nil)
(setq save-interprogram-paste-before-kill t)
(windmove-default-keybindings)
(xclip-mode 1)
;;(defvaralias 'c-basic-offset 'tab-width)
;;(defvaralias 'cperl-indent-level 'tab-width)
(powerline-center-evil-theme)
(global-linum-mode 1)

;; Files 
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Hastebin
(add-to-list 'load-path "~/.emacs.d/emacs-haste-client")
(autoload 'haste "haste" nil t)
(eval-after-load "haste"
  '(progn
     (setq haste-server   "https://hastebin.cuttlerat.ru")))
(global-evil-leader-mode)
(evil-leader/set-key "c" 'haste)

;; Keys bindings

;; ESC quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;; Splits
(define-key evil-normal-state-map (kbd "H")  'windmove-left)
(define-key evil-normal-state-map (kbd "L") 'windmove-right)

;; PgUp-PgDown
(define-key evil-normal-state-map (kbd "K") (lambda ()
                    (interactive)
                    (evil-scroll-up nil)))
(define-key evil-normal-state-map (kbd "J") (lambda ()
                        (interactive)
                        (evil-scroll-down nil)))
;; Tabs
(setq tab-stop-list (number-sequence 4 120 4))
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
(global-set-key "\M-f" 'hippie-expand)
(add-hook 'yaml-mode-hook
    (lambda ()
    (define-key evil-insert-state-map (kbd "TAB") 'yaml-indent-line)))
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Neotree
(define-key evil-normal-state-map "\C-n" 'neotree-toggle)
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-quick-look)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map [escape] 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-quick-look)))
