(use-package company
  :config
  (setq company-tooltip-limit 20)
  (setq company-tooltip-align-annotations 't)
  (setq company-idle-delay .3)
  (setq company-begin-commands '(self-insert-command))
  ;; (global-set-key (kbd "C-c /") 'company-files)
  (add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'after-init-hook 'global-company-mode)
  (use-package company-quickhelp
    :config
    (setq company-quickhelp-delay 3)
    )
  (require 'company-quickhelp)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-limit 25)
  (setq company-tooltip-flip-when-above t)
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0.3)
  (setq company-backends '(company-ycmd company-yasnippet company-dabbrev))
  )

;; Code formatting
(use-package format-all
  :bind (
         ("C-x M-l" . format-all-buffer))
  )

(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode t))

(use-package yafolding
  :config
  (defvar yafolding-mode-map
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "<C-S-return>") #'yafolding-hide-parent-element)
      (define-key map (kbd "<C-M-return>") #'yafolding-toggle-all)
      (define-key map (kbd "<C-return>") #'yafolding-toggle-element)
      map))
  (yafolding-mode)
  (advice-add 'whitespace-cleanup :around #'yafolding-show-all)
  (advice-add 'whitespace-cleanup-region :around #'yafolding-show-all)
  (advice-add 'delete-trailing-whitespace :around #'yafolding-show-all)
  )


(use-package smartparens
  :config
  (smartparens-global-mode t)
  )
(show-paren-mode 1)


(defun forward-or-backward-sexp
    (&optional
     arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "^p")
  (cond ((looking-at "\\s(")
         (forward-sexp arg))
        ((looking-back "\\s)" 1)
         (backward-sexp arg))
        ;; Now, try to succeed from inside of a bracket
        ((looking-at "\\s)")
         (forward-char)
         (backward-sexp arg))
        ((looking-back "\\s(" 1)
         (backward-char)
         (forward-sexp arg))))
(global-set-key (kbd "C-%") 'forward-or-backward-sexp)
(setq path-to-ctags "/usr/local/bin/ctags")
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  )
(global-display-line-numbers-mode)


;; Flycheck
(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq flycheck-indication-mode (quote left-fringe))
  (setq flycheck-python-flake8-executable "flake8")
  (setq flycheck-display-errors-delay 0.3)
  (use-package flycheck-pos-tip
    :config
    (with-eval-after-load 'flycheck (flycheck-pos-tip-mode))
    )
  )

;; Yasnippet
(use-package yasnippet
  :diminish
  :config
  (yas-global-mode 1)
  (use-package yasnippet-snippets)
  (use-package helm-c-yasnippet
    :bind (("S-M-<tab>" . helm-yas-complete))
    :config
    (setq helm-yas-space-match-any-greedy t))
  )

;; Python
