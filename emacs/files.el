;; Git Client
(use-package magit
  :config
  (if EVIL_ENABLED (
                    use-package evil-magit
                    :config
                    (setq evil-magit-state 'normal)
                    )
    )
  (setq magit-completing-read-function 'magit-ido-completing-read)
  (global-set-key (kbd "C-x g") 'magit-status)
  (setq vc-handled-backends (delq 'Git vc-handled-backends))
  ;; (use-package magithub
  ;;   :config
  ;;   (magithub-feature-autoinject t)
  ;;   )
  )


(eval-after-load "dired" '(progn (define-key dired-mode-map "F" 'my-dired-find-file)
                                 (defun my-dired-find-file
                                     (&optional
                                      arg)
                                   "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
                                   (interactive "P")
                                   (let* ((fn-list (dired-get-marked-files nil arg)))
                                     (mapc 'find-file fn-list)))))


(goto-address-mode)
(setq-default indent-tabs-mode nil
              tab-width 4)
;; (global-set-key (kbd "M-s $ DEL") 'omni-scratch)
;; (global-set-key (kbd "M-s $ -") 'omni-scratch-major)
;; (global-set-key (kbd "M-s $ _") 'omni-scratch-buffer)
;; (global-set-key (kbd "M-s $ $") 'omni-scratch-goto-latest)
;; (global-set-key (kbd "M-s $ b") 'omni-scratch-buffers)
(setq auto-indent-on-visit-file 0)
(global-auto-revert-mode t)
(require 'auto-indent-mode)
(setq vc-follow-symlinks t)
(require 'generic-x)

(use-package projectile
  :config
  (projectile-mode +1)
  (use-package counsel-projectile
    :config
    (counsel-projectile-mode +1)
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
    )
  ;; (use-package helm-projectile
  ;; :bind (("M-g p" . helm-projectile)))
  )

;; (global-whitespace-mode t)
(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("/tmp/zsh*" . sh-mode))
;; (with-eval-after-load "ispell"
;;   (setq ispell-program-name "hunspell")
;;   (setq ispell-dictionary "en_US,de_DE,ru_RU")
;;   (ispell-set-spellchecker-params)
;;   (ispell-hunspell-add-multi-dic "en_US,de_DE,ru_RU"))

(require 'man)
(set-face-attribute 'Man-overstrike nil :inherit font-lock-type-face :bold t)
(set-face-attribute 'Man-underline nil :inherit font-lock-keyword-face :underline t)
(setq explicit-shell-file-name "/usr/local/bin/bash")
(add-hook 'term-mode-hook (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'eshell-mode-hook (lambda () (setq show-trailing-whitespace nil)))
;; Mathematica
(use-package wolfram-mode
  :config
  (autoload 'wolfram-mode "wolfram-mode" nil t)
  (autoload 'run-wolfram "wolfram-mode" nil t)
  (setq wolfram-program "/Applications/Mathematica.app/Contents/MacOS/MathKernel")
  ;; (add-to-list 'auto-mode-alist '("\.[nb,m]$" . wolfram-mode))
  (setq wolfram-path "/Applications")
  )

(use-package ein
  :config
  (require 'ein)
  (require 'ein-notebook)
  (require 'ein-subpackages)
  (setq ein:completion-backend 'ein:use-company-backend)
  )


