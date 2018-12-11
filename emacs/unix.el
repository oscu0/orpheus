(use-package eshell-prompt-extras
  :config
  (with-eval-after-load "esh-opt"
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil eshell-prompt-function 'epe-theme-lambda))
  (defun *-eshell-clear ()
    "Clear `eshell' buffer, comint-style."
    (interactive)
    (let ((input (eshell-get-old-input)))
      (eshell/clear-scrollback)
      (eshell-emit-prompt)
      (insert input)))
  )

