(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

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
(global-rainbow-delimiters-mode)

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
                                                     rust-mode
                                                     plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))

(setq make-backup-files nil)

(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)

(require 'cc-mode)
(setq-default c-basic-offset 4 c-default-style "linux")
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)
(require 'auto-complete-clang)
(define-key c++-mode-map (kbd "M-S-<return>") 'ac-complete-clang)
(require 'ecb)
(require 'ecb-autoloads)
(setq ecb-layout-name "left1")
(setq ecb-show-sources-in-directories-buffer 'always)
(setq ecb-compile-window-height 12)

(require 'rust-mode)
(require 'flymake-rust)
(add-hook 'rust-mode-hook 'flymake-rust-load)
(add-hook 'prog-mode-hook
          '(lambda ()
             (when (derived-mode-p 'rust-mode) 
               (ggtags-mode 1))))
(add-hook 'prog-mode-hook
          '(lambda ()
             (when (derived-mode-p 'rust-mode)
               (define-key ggtags-mode-map (kbd "M-]") 'ggtags-grep)
               )))
