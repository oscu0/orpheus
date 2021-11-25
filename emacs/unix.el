(defun eshell-new()
  "Open a new instance of eshell."
  (interactive)
  (eshell 'N))

(global-set-key (kbd "C-`") 'eshell-new)

;; Make processes’ outputs read-only. The prompt is easy.
(setq comint-prompt-read-only t)
;; Outputs. Now you cannot delete them, but they still can be interleaved with some other text.
(add-hook 'comint-preoutput-filter-functions
          (lambda (text)
            (propertize text 'read-only t)))
;; So we need tackle rear-nonsticky:
(defadvice comint-output-filter (after michalrus/comint-output-read-only activate)
  (let* ((start-marker comint-last-output-start)
         (proc (get-buffer-process (current-buffer)))
         (end-marker (if proc (process-mark proc) (point-max-marker))))
    (when (< start-marker end-marker) ;; Account for some of the IELM’s wilderness.
      (let ((inhibit-read-only t))
        ;; Disallow interleaving.
        (remove-text-properties start-marker (1- end-marker) '(rear-nonsticky))
        ;; Make sure that at `max-point' you can always append.
        ;; Important for bad REPLs that keep writing after giving us prompt (e.g. sbt).
        (add-text-properties (1- end-marker) end-marker '(rear-nonsticky t))
        ;; Protect fence (newline of input, just before output).
        (when (eq (char-before start-marker) ?\n)
          (remove-text-properties (1- start-marker) start-marker '(rear-nonsticky))
          (add-text-properties    (1- start-marker) start-marker '(read-only t))))))
  ;; What’s left is some initial welcome `insert's and process exit messages, but whatever.
  )



(use-package eshell-prompt-extras
  :config
  (with-eval-after-load "esh-opt"
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-lambda))
  (with-eval-after-load "esh-opt"
    (use-package virtualenvwrapper
      :config
      (venv-initialize-eshell)
      )
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-lambda))
  )

;; (use-package conda
;;   :init
;;   (custom-set-variables
;;    '(conda-anaconda-home "/usr/local/anaconda3"))
;;   :config
;;   (conda-env-initialize-interactive-shells)
;;   (conda-env-initialize-eshell)
;;   (conda-env-autoactivate-mode t)
;;   )

(defun execute-shell-command-on-buffer (shell-command-text)
  (interactive "MShell command:")
  (shell-command (format shell-command-text (shell-quote-argument buffer-file-name)))
  )
(global-set-key (kbd "C-M-!") 'execute-shell-command-on-buffer)
