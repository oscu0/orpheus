;; Misc settings
(column-number-mode t)
(line-number-mode t)
(size-indication-mode t)
(global-visual-line-mode t)
(setq line-move-visual nil)
(setq visual-line-fringe-indicators nil)
(setq-default word-wrap t)
(setq-default truncate-lines t)
(setq enable-recursive-minibuffers t)
(defun joaot/delete-process-at-point ()
  (interactive)
  (let ((process (get-text-property (point) 'tabulated-list-id)))
    (cond ((and
            process
            (processp process))
           (delete-process process)
           (revert-buffer))
          (t
           (error
            "no process at point!")))))
(setq disabled-command-function nil)
(xterm-mouse-mode t)
(setq mouse-wheel-scroll-amount '(1 ((shift) . t)))
(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)       ;; scroll window under mouse
(setq scroll-step 0) ;; keyboard scroll one line at a time
(setq scroll-error-top-bottom t)
;; (global-set-key [mouse-4] 'scroll-down-line)
;; (global-set-key [mouse-5] 'scroll-up-line)
(setq scroll-preserve-screen-position 'always)
(setq scroll-conservatively 1)
;; (desktop-save-mode 1)
(savehist-mode 1)
(global-hl-todo-mode 1)
(global-git-gutter-mode 1)
(set-language-environment "UTF-8")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(fset 'yes-or-no-p 'y-or-n-p)
(setq require-final-newline t)
(setq next-line-add-newlines nil)
(setq ring-bell-function 'ignore)
(menu-bar-mode nil)
(scroll-bar-mode t)
(setq-default show-trailing-whitespace t)
(setq-default grep-highlight-matches t grep-scroll-output t)

(defun set-code-font ()
  (set-frame-font "Fira Code" nil t)
  (set-face-attribute 'default nil
                      :height 120)
  )
(defun set-text-font ()
  (set-frame-font "CMU Sans Serif" nil t)
  (set-face-attribute 'default nil
                      :height 140)
  )
(use-package crux
  :config
  (global-set-key (kbd "C-x C-M-e") 'crux-eval-and-replace)
  (global-set-key (kbd "C-x 4 t") 'crux-transpose-windows)
  (global-set-key (kbd "C-c d") 'crux-duplicate-current-line-or-region)
  (global-set-key (kbd "C-c M-d") 'crux-duplicate-and-comment-current-line-or-region)
  (setq comment-empty-lines t)
  (global-set-key (kbd "C-x M-t") 'crux-visit-term-buffer)
  (global-set-key (kbd "C-x M-k") 'crux-kill-other-buffers)
  ;; (crux-with-region-or-buffer 'indent-region)
  ;; (crux-with-region-or-line 'kill-region)
  (crux-with-region-or-line comment-or-uncomment-region)
  (crux-with-region-or-line kill-region)
  (crux-with-region-or-buffer untabify)
  )

;; Completion and selection narrowing framework
;; (use-package helm
;;   :config
;;   (use-package helm-swoop
;;     :bind (
;;            ("M-g s" . helm-swoop))
;;     )

;;   (use-package helm-company
;;     :config
;;     (eval-after-load 'company
;;       '(progn
;;          (setq company-frontends nil)
;;          (define-key company-mode-map (kbd "M-<tab>") 'helm-company)
;;          (define-key company-active-map (kbd "M-<tab>") 'helm-company)))
;;     )
;;   (global-set-key (kbd "M-x") #'helm-M-x)
;;   (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
;;   (global-set-key (kbd "C-x C-f") #'helm-find-files)
;;   (global-set-key (kbd "C-x b") #'helm-mini)
;;   (helm-mode 1)
;;   (setq helm-ff-skip-boring-buffers t)
;;   (setq helm-skip-boring-buffers t)
;;   (helm-autoresize-mode 1)
;;   (setq helm-autoresize-max-height 25)
;;   (setq helm-autoresize-min-height 25)
;;   (setq helm-echo-input-in-header-line t)
;;   (defun helm-hide-minibuffer-maybe ()
;;     (when (with-helm-buffer helm-echo-input-in-header-line)
;;       (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
;;         (overlay-put ov 'window (selected-window))
;;         (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
;;                                 `(:background ,bg-color :foreground ,bg-color)))
;;         (setq-local cursor-type nil))))
;;   (add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)
;;   )

(use-package ivy
  :config
  (use-package imenu-anywhere
    :bind (("M-g d" . ivy-imenu-anywhere)))
  (setq ivy-display-style 'fancy)
  (setq ivy-use-virtual-buffers t)
  (ivy-mode 1)
  (setq ivy-use-selectable-prompt t)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-wrap t)
  
  (use-package ivy-dired-history
    :config
    (require 'savehist)
    (add-to-list 'savehist-additional-variables 'ivy-dired-history-variable)
    (savehist-mode 1)
    (with-eval-after-load 'dired
      (require 'ivy-dired-history)
      (define-key dired-mode-map "," 'dired)))
  (use-package ivy-yasnippet
    :bind ("S-<tab>" . ivy-yasnippet))
  (use-package ivy-rich
    :config
    (ivy-rich-mode 1)
    (setq ivy-format-function #'ivy-format-function-line)
    :diminish)
  (use-package counsel
    :config
    (counsel-mode t)
    )
  (use-package counsel-dash)
  (use-package flyspell-correct-ivy
    )
  :diminish)
  (use-package swiper
    :bind ("C-S-s" . swiper)
    :bind ("C-S-M-s" . swiper-multi)
    )

(use-package highlight-symbol
  :bind (
         ("M-n" . highlight-symbol-next)
         ("M-p" . highlight-symbol-prev)
         )
  :config
  (highlight-symbol-mode)
  )

;; Behavior and avigation
(use-package google-translate
  :bind (
         ("C-c t" . google-translate-at-point)
         ("C-c T" . google-translate-query-translate)
         )
  :config
  (require 'google-translate-default-ui)
  )

(use-package ace-link
  :bind (("M-o" . ace-link-addr))
  :config
  (ace-link-setup-default)
  )

(use-package ace-window
  :bind (("C-x o" . ace-window)))

(setq comment-empty-lines t)

(defun kill-whitespace ()
  "Kill the whitespace between two non-whitespace characters"
  (interactive "*")
  (save-excursion
    (save-restriction
      (save-match-data
        (progn
          (re-search-backward "[^ \t\r\n]" nil t)
          (re-search-forward "[ \t\r\n]+" nil t)
          (replace-match "" nil nil))))))
(global-set-key (kbd "C-DEL") 'kill-whitespace)

(use-package undo-tree
  :config
  (global-undo-tree-mode)
  (setq undo-tree-visualizer-diff t)
  (setq undo-tree-visualizer-timestamps t)
  )
(transient-mark-mode 1)
(setq shift-select-mode t)
(delete-selection-mode t)

(use-package expand-region
  :bind (
         ("C-." . er/expand-region)
         ("C-," . er/contract-region)
         )
  )
;; Keybinds
(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))
(global-set-key '[(kp-delete)] 'delete-char)
(global-set-key (kbd "s-<backspace>") 'backward-kill-line)
(global-set-key (kbd "s-<delete>") 'kill-line)
(global-set-key (kbd "s-<left>") 'beginning-of-line)
(global-set-key (kbd "s-<right>") 'end-of-line)
(global-set-key (kbd "C-a") 'beginning-of-line)
(global-set-key (kbd "C-e") 'end-of-line)
(global-set-key (kbd "M-<delete>") 'kill-word)
(global-set-key (kbd "C-_") 'undo-only)`a
(global-set-key (kbd "s-z") 'undo-only)
(global-set-key (kbd "M-;") 'comment-or-uncomment-region)
(global-set-key (kbd "s-/") 'comment-or-uncomment-region)

(setq undo-limit 160000)
(setq undo-strong-limit 320000)


(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq make-backup-files nil)          ; stop creating backup~ files
(setq auto-save-default nil)          ; stop creating #autosave# files

(use-package dumb-jump
  :bind ("M-g D" . dumb-jump-go)
  :bind ("M-g M-D" . dumb-jump-back)
  :config
  (setq dumb-jump-selector 'ivy)
  (setq dumb-jump-aggressive nil)
  )


;; (use-package minimap
;;   :config
;;   (setq minimap-display-semantic-overlays t)
;;   (setq mimimap-width-fraction 0.05)
;;   )

(require 'semantic/ia)
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)
(global-semantic-idle-completions-mode t)
(global-semantic-decoration-mode t)
(global-semantic-highlight-func-mode t)
(global-semantic-show-unmatched-syntax-mode t)
(semantic-mode 1)
(use-package ecb)
