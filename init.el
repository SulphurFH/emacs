;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://elpa.emacs-china.org/melpa/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    material-theme
    py-autopep8
    web-mode
    emmet-mode
    direx
    popwin))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t)
(setq make-backup-files nil)
(load-theme 'material t)
(global-linum-mode t)
(scroll-bar-mode -1)
(set-face-attribute 'default nil :height 120)
(tool-bar-mode -1)
(global-company-mode 1)


;; PYTHON CONFIGURATION
;; --------------------------------------

;;(package-initialize)
;;(exec-path-from-shell-copy-env "PATH")
(elpy-enable)
(elpy-use-ipython)

;; use flycheck not flymake with elpy
;; --------------------------------------

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
;; --------------------------------------

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; EMMET-MODE
;; --------------------------------------

(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)

;; WEB-MODE
;; --------------------------------------

(require 'web-mode)
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       '(("\\.html\\'" . web-mode))
       auto-mode-alist))

(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

;; SR-SPEEDBAR
;; -------------------------------------
;;(require 'sr-speedbar);;这句话是必须的
;;(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));;开启程序即启用
;;(setq sr-speedbar-right-side nil)


;; DIREX+POPWIN
;; -------------------------------------

(require 'popwin)
(popwin-mode 1)

(require 'direx)
(push '(direx:direx-mode :position left :width 30 :dedicated t)
     popwin:special-display-config)

(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)






;; alt+; to DELETE
;; --------------------------------------

(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and
we are not at the end of the line, then comment current line.
Replaces default behaviour of comment-dwim,
when it inserts comment at the end of the line. "

  (interactive "*P")
  (comment-normalize-vars)

  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key "\M-;" 'qiang-comment-dwim-line)






;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (exec-path-from-shell web-mode sr-speedbar py-autopep8 material-theme flycheck emmet-mode elpy better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
