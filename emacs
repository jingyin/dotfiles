(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-tags-on-save t)
 '(show-paren-mode t))

(defun system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))

(defun system-is-linux ()
  (interactive)
  (string-equal system-type "gnu/linux"))

(if (system-is-mac)
    (progn
      (setq geiser-racket-binary "/Applications/Racket v5.3.6/bin/racket")
      (setq ns-command-modfier 'meta)))

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(require 'rainbow-delimiters)
;; (global-rainbow-delimiters-mode)

(load-theme 'solarized-light t)

(require 'quack)
(setq geiser-repl-use-other-window nil)
(show-paren-mode 1)
(setq show-paren-delay 0)

(setq-default indent-tabs-mode nil)
(setq backup-inhibited nil)
(setq auto-savedefault nil)
(setq tab-width 4)
(global-linum-mode)
(global-visual-line-mode)

(define-key global-map (kbd "RET") 'newline-and-indent)

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-lisp-mode lisp-mode
                                                     clojure-mode
                                                     scheme-mode
                                                     haskell-mode
                                                     ruby-mode
                                                     rspec-mode
                                                     python-mode
                                                     c-mode
                                                     c++-mode
                                                     objc-mode
                                                     latex-mode
                                                     plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))

(setq make-backup-files nil)

(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))
(let ((my-cabal-path (expand-file-name "~/Library/Haskell/bin"))
      (sys-cabal-path (expand-file-name "/Library/Haskell/bin")))
  (setenv "PATH" (concat my-cabal-path ":" sys-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)


(eval-after-load 'haskell-mode '(progn
                                  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
                                  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
                                  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
                                  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
                                  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
                                  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
                                  (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))
(eval-after-load 'haskell-cabal '(progn
                                   (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
                                   (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
                                   (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
                                   (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile))
(eval-after-load 'haskell-cabal
  '(define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile))
