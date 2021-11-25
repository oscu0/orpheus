(setq gc-cons-threshold 200000000)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (require 'use-package))
(setq use-package-always-ensure t)

(setq emacs-custom-path "~/.config/orpheus/emacs/")

(load (concat emacs-custom-path "init.el"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "#93a1a1" :slant italic))))
 '(line-number-current-line ((t :weight bold))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(counsel-projectile-mode t nil (counsel-projectile))
 '(custom-safe-themes
   '("c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "5a39d2a29906ab273f7900a2ae843e9aa29ed5d205873e1199af4c9ec921aaab" "8c1dd3d6fdfb2bee6b8f05d13d167f200befe1712d0abfdc47bb6d3b706c3434" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "d96587ec2c7bf278269b8ec2b800c7d9af9e22d816827639b332b0e613314dfd" "50ff65ab3c92ce4758cc6cd10ebb3d6150a0e2da15b751d7fbee3d68bba35a94" "cbd8e65d2452dfaed789f79c92d230aa8bdf413601b261dbb1291fb88605110c" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "6daa09c8c2c68de3ff1b83694115231faa7e650fdbb668bc76275f0f2ce2a437" "fee4e306d9070a55dce4d8e9d92d28bd9efe92625d2ba9d4d654fc9cd8113b7f" "4feee83c4fbbe8b827650d0f9af4ba7da903a5d117d849a3ccee88262805f40d" "3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "99c86852decaeb0c6f51ce8bd46e4906a4f28ab4c5b201bdc3fdf85b24f88518" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "60e09d2e58343186a59d9ed52a9b13d822a174b33f20bdc1d4abb86e6b17f45b" "cea3ec09c821b7eaf235882e6555c3ffa2fd23de92459751e18f26ad035d2142" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "b3bcf1b12ef2a7606c7697d71b934ca0bdd495d52f901e73ce008c4c9825a3aa" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default))
 '(mac-pseudo-daemon-mode t)
 '(magit-log-section-arguments '("--graph" "--color" "--decorate" "-n256"))
 '(package-selected-packages
   '(color-theme-sanityinc-tomorrow colortheme-sanityinc-tomorrow 0blayout conda virtualenv-wrapper imenu-anywjhere ecb sublimity minimap comint json-mode dumb-jump uvy-yasnippet all-the-icons all-the-icons-dired all-the-icons-ivy counsel-dash counsel-etags counsel-gtags counsel-projectile counsel-tramp flyspell-correct-ivy ivy-dired-history ivy-rich ivy-yasnippet counsel ido-completing-read+ c-mode highlight-symbol helm-projectile aggressive-indent osx-pseudo-daemon use-package boxquote ibuffer-projectile wgrep-helm wgrep dtrt-indent evil-magit hydra ac-helm angular-snippets aws-snippets clojure-snippets common-lisp-snippets django-snippets go-snippets haskell-snippets helm-c-yasnippet java-snippets php-auto-yasnippets r-autoyas react-snippets yasnippet-snippets yatemplate espresso-theme evil-rsi linum-relative rjsx-mode helm-swoop omni-scratch mac-pseudo-daemon apples-mode aurora-config-mode bbcode-mode bison-mode bitbake blockdiag-mode csgo-conf-mode dkdo easy-jekyll erc-view-log erlang gf gitattributes-mode jgraph-mode lcb-mode livescript-mode logview motion-mode ng2-mode nix-mode paperless picolisp-mode po-mode pollen-mode preseed-generic-mode qt-pro-mode reason-mode redprl remark-mode scad-mode scss-mode sml-mode stylus-mode textile-mode textmate-to-yas thrift todotxt tornado-template-mode typescript-mode vue-html-mode xahk-mode yarn-mode adoc-mode lua-mode swift-mode wsd-mode elf-mode elvish-mode extempore-mode fic-mode forth-mode fountain-mode gl-conf-mode gnu-apl-mode graphql-mode ham-mode haskell-mode helm-tramp hoa-mode homebrew-mode html2org intel-hex-mode jira-markup-mode julia-mode kaesar-mode kotlin-mode ksp-cfg-mode launch-mode less-css-mode lfe-mode load-dir lockfile-mode lognav-mode magic-filetype matlab-mode metascript-mode mgmtconfig-mode mips-mode mo-git-blame actionscript-mode ada-mode apache-mode arduino-mode bash-completion bln-mode bmx-mode cask-mode chef-mode clojure-mode cmake-mode cobol-mode coffee-mode cpanfile-mode csharp-mode django-mode djvu docker-compose-mode dokuwiki-mode gist magithub google-translate ace-link ace-window dired-imenu flyspell-correct-helm helm-bind-key cyberpunk-theme dark-souls evil-anzu evil-ediff evil-lion evil-numbers flycheck-css-colorguard flycheck-objc-clang crux ranger elpy symon drag-stuff dimmer iy-go-to-char imenu-anywhere tabbar elmacro company-edbi edbi-django edbi-sqlite magit-todos edbi elisp-format helm-descbinds helm-dash helm-google wolfram wolfram-mode ido-vertical-mode helm-fuzzier diredfl expand-region yaml-mode web-mode virtualenvwrapper vimrc-mode tf2-conf-mode systemd ssh-config-mode ssh sr-speedbar solarized-theme smooth-scrolling smooth-scroll smartparens smart-tab smart-mode-line-powerline-theme sed-mode scala-mode robots-txt-mode rhtml-mode reveal-in-osx-finder realgud-pry realgud-old-debuggers rainbow-delimiters qml-mode python-mode powershell pip-requirements perl6-mode pcomplete-extension parent-mode ninja-mode nginx-mode nasm-mode multi-term markdown-mode magit jinja2-mode jar-manifest-mode ini-mode iasm-mode hl-todo hgignore-mode helm-flycheck helm-flx helm-company helm-ag go-mode gnuplot-mode gitignore-templates gitignore-mode gitconfig-mode git-gutter format-all flycheck-pos-tip flx-isearch fish-mode fireplace fill-column-indicator exec-path-from-shell evil-tutor evil-surround evil-commentary ess eshell-prompt-extras esh-autosuggest emmet-mode emamux elscreen ein dotenv-mode dockerfile-mode docker diminish dash-at-point cython-mode cuda-mode csv-mode csv crm-custom company-ycmd company-web company-shell company-quickhelp company-php company-math company-irony-c-headers company-irony company-c-headers company-bibtex company-auctex company-anaconda color-theme-sanityinc-solarized cheatsheet better-defaults basic-mode base16-theme auto-indent-mode anzu angular-mode ace-popup-menu 4clojure yafolding read-aloud))
 '(tabbar-mwheel-mode nil nil (tabbar)))
