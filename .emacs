(load-library "iso-transl")

(transient-mark-mode)

(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "linux-tabs-only")))

(global-set-key [(control x)(y)] (quote compile))
(global-set-key [(control x)(control y)] (quote compile))

(column-number-mode 1)

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

(set-variable (quote latex-run-command) "pdflatex")

(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/dev/gsoc")
                                       filename))
                (setq indent-tabs-mode t)
                (c-set-style "linux-tabs-only")))))


;;(load "auctex.el" nil t t)
;;(load "preview-latex.el" nil t t)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(require 'reftex)


(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode


(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (TeX-PDF-mode 1))
)

;; crouton-stuff

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/dev/chromebook/crouton")
                                       filename))
                (setq c-default-style "linux" c-basic-offset 4)
                (setq-default indent-tabs-mode nil)))))

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/dev/chromebook/cros")
                                       filename))
                (setq indent-tabs-mode t)
                (c-set-style "linux-tabs-only")))))

;; primus-stuff

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/dev/chromebook/primus")
                                       filename))
                (setq c-default-style "linux" c-basic-offset 2)
                (setq-default indent-tabs-mode nil)))))


(setq c-default-style "linux" c-basic-offset 4)
(setq-default indent-tabs-mode nil)

(add-hook 'c-mode-hook '(lambda () (highlight-lines-matching-regexp ".\\{81\\}" 'hi-yellow) (highlight-regexp " * $" 'hi-green)))
(add-hook 'sh-mode-hook '(lambda () (highlight-lines-matching-regexp ".\\{81\\}" 'hi-yellow) (highlight-regexp " * $" 'hi-green)))
(add-hook 'diff-mode-hook '(lambda ()
    (highlight-lines-matching-regexp ".\\{82\\}" 'hi-yellow)
    (highlight-regexp " * $" 'hi-green)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(tool-bar-style (quote image)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 89 :width normal)))))
