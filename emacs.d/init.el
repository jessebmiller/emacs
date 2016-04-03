(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))

;; get some ido goodness
(ido-mode 1)
(ido-everywhere 1)
;; in org-mode and magit
(setq org-completion-use-ido t)
(setq magit-completing-read-function 'magit-ido-completing-read)
;; in M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;; keep smex items in the mounted volume
(setq smex-save-file "~/.emacs.d/smex-items")

;; disable auto-save
(setq auto-save-default nil)

;; whitespace and long line highlighting
(require 'whitespace)
(setq whitespace-style '(face trailing lines-tail))
(set-face-attribute 'whitespace-trailing nil
                    :background "#585858")
(set-face-attribute 'whitespace-line nil
                    :background "#585858"
                    :foreground "#808080")
(global-whitespace-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode ssh-file-modes smex paredit markdown-mode magit ido-ubiquitous go-mode closure-lint-mode clojurescript-mode cider better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )