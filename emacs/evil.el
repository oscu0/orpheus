;; Vim Emulation
(setq evil-want-integration nil)
(if EVIL_ENABLED
    (use-package evil
      ;; :init
      ;; (setq evil-want-integration nil)
      :config
      (use-package evil-commentary
        :config
        (evil-commentary-mode)
        )
      (use-package evil-collection
        :init
        (setq evil-want-keybinding nil)
        :config
        (when (require 'evil-collection nil t)
          (evil-collection-init))
        (setq evil-collection-company-use-tng nil)
        (setq evil-collection-setup-minibuffer t)
        )
      (use-package evil-rsi
        :config
        (evil-rsi-mode))
      (use-package evil-surround
        :config
        (global-evil-surround-mode 1)
        )
      (use-package evil-lion
        :config
        (evil-lion-mode)
        )

      (use-package evil-commentary
        :diminish)
      ;; (setq evil-normal-state-modes
      ;;       (append evil-emacs-state-modes
      ;;               ;; evil-insert-state-modes
      ;;               evil-normal-state-modes
      ;;               evil-motion-state-modes))
      (defun my-center-line (&rest _)
        (evil-scroll-line-to-center nil))
      (advice-add 'evil-search-next :after #'my-center-line)
      (setq evil-search-wrap t
            evil-regexp-search t)
      (setq evil-esc-delay 0)
      (evil-mode t)
      )
  )
