;; GUI-specific tweaks
(if (display-graphic-p)
    (progn
      ;; n(require 'sublimity)
      ;; (require 'sublimity-scroll)
      ;; (sublimity-mode t)
      ;; (setq base16-distinct-fringe-background nil)
      ;; (setq base16-theme-256-color-source 'base16_shell)
      ;; (load-theme 'base16-summerfruit-light t)
      (use-package solarized-theme
        :init
        (setq solarized-high-contrast-mode-line t)
        (setq solarized-use-more-italic nil)
        (setq solarized-distinct-fringe-background t)
        :config
        (load-theme 'solarized-light t)
        )
      (custom-set-faces '(line-number-current-line ((t :weight bold))))
      (pixel-scroll-mode)
      (set-code-font)
      (setq-default cursor-type 'bar)
                                        ; (defun iterm ()
      ;;   "Go to present working dir and focus iterm"
      ;;   (interactive)
      ;;    (dired-smart-shell-command "open -a iTerm $PWD" nil nil))
      ))

;; Mac-specific tweaks
(when (memq window-system '(mac ns x))
  (if (display-graphic-p)
      (progn
        (defun iterm ()
          "Open the current directory of the buffer in iTerm."
          (interactive)
          (let* ((iterm-app-path "/Applications/iTerm.app")
                 (iterm-brew-path "/opt/homebrew-cask/Caskroom/iterm2/2.1.4/iTerm.app")
                 (iterm-path (if (file-directory-p iterm-app-path) iterm-app-path iterm-brew-path)))
            (shell-command (concat "open -a " iterm-path " ."))))
        (global-set-key (kbd "C-x t") 'iterm)
        (use-package osx-pseudo-daemon
          :config
          (mac-pseudo-daemon-mode))))
  (global-set-key (kbd "C-z") nil)
  (setq ns-right-alternate-modifier "none")
  (use-package exec-path-from-shell
    :config
    (exec-path-from-shell-initialize)
    )
  (use-package read-aloud
    :config
    (setq read-aloud-engine "say")
    (crux-with-region-or-buffer read-aloud-this)
    (global-set-key (kbd "M-ESC") 'read-aloud-this)
    )
  (setq ns-pop-up-frames 'fresh))

;; Search match count
(use-package anzu
  :config
  (global-anzu-mode +1)
  (if EVIL_ENABLED (
                    use-package evil-anzu
                    ))
  )

(setq inhibit-startup-message t)

(winner-mode)
(defvar ediff-last-windows nil
  "Last ediff window configuration.")
(defun ediff-restore-windows ()
  "Restore window configuration to `ediff-last-windows'."
  (set-window-configuration ediff-last-windows)
  (remove-hook 'ediff-after-quit-hook-internal
               'ediff-restore-windows))
(defadvice ediff-buffers (around ediff-restore-windows activate)
  (setq ediff-last-windows (current-window-configuration))
  (add-hook 'ediff-after-quit-hook-internal 'ediff-restore-windows)
  ad-do-it)

;; Diminish
(require 'diminish)
(diminish 'dtrt-indent-mode)
(diminish 'winner-mode)
(diminish 'goto-address-mode)
(diminish 'yas-global-mode)
(diminish 'yas-minor-mode)
(diminish 'global-undo-tree-mode)
(diminish 'undo-tree-mode)
(diminish 'global-ycmd-mode)
(diminish 'ycmd-mode)
(diminish 'global-flycheck-mode)
(diminish 'flyspell-mode)
(diminish 'smartparens-mode)
(diminish 'company-mode)
(diminish 'global-company-mode)
(diminish 'global-anzu-mode)
(diminish 'anzu-mode)
(diminish 'helm-mode)
(diminish 'eldoc-mode)
(diminish 'global-git-gutter-mode)
(diminish 'git-gutter-mode)
(diminish 'global-visual-line-mode)
(diminish 'visual-line-mode)
(diminish 'yafolding-mode)
