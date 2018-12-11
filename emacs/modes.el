(global-eldoc-mode t)

(use-package python
  :config
  (use-package elpy
    :config
    (elpy-enable)
    (setq elpy-modules '(elpy-module-sane-defaults elpy-module-company elpy-module-eldoc elpy-module-highlight-indentation elpy-module-pyvenv elpy-module-django))
    )
  (use-package sphinx-doc
    :config
    (add-hook 'python-mode-hook (lambda ()
                                  (sphinx-doc-mode t))))
  )

(use-package cc-mode
  :config
  (use-package irony
    :config
    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)
    (use-package irony-eldoc
      :config
      (add-hook 'irony-mode-hook #'irony-eldoc)
      )
    (use-package company-irony
      :config
      (eval-after-load 'company
        '(add-to-list 'company-backends 'company-irony)))
    )
  )

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

  )

(use-package tex
  :ensure auctex
  :config
  (use-package auctex
    :defer t
    :config
    (setq TeX-auto-save t)
    (setq TeX-parse-self t)
    (use-package company-auctex
      :config
      (company-auctex-init))))

(use-package tf2-conf-mode)
