(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))

(defun system-is-linux ()
  (interactive)
  (string-equal system-type "gnu/linux"))

(if (system-is-mac)
    (progn
      (setq ns-command-modifier 'meta)))

(if (system-is-linux)
    (progn 
      (require 'ibus)
      ;; Turn on ibus-mode automatically after loading .emacs
      (add-hook 'after-init-hook 'ibus-mode-on)
      ;; Use C-SPC for Set Mark command
      (ibus-define-common-key ?\C-\s nil)
      ;; Use C-/ for Undo command
      (ibus-define-common-key ?\C-/ nil)
      ;; Change cursor color depending on IBus status
      (setq ibus-cursor-color '("red" "blue" "limegreen"))
      ;; Use S-SPC to toggle input status
      (ibus-define-common-key ?\S-\s nil)
      (global-set-key (kbd "s-SPC") 'ibus-toggle)))

(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq command-line-default-directory "~/")

(add-hook 'java-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode    scheme-mode
						     haskell-mode    ruby-mode
						     rspec-mode      python-mode
						     c-mode          c++-mode
						     objc-mode       latex-mode
						     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))

(setq make-backup-files nil)
