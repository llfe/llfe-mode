;;; llfe-mode.el --- Minor mode for Literate LFE.

;;; Commentary:

;;; Code:

(require 'font-lock)

(require 'markdown-mode)

(require 'mmm-mode)

(require 'mmm-auto)

(defgroup llfe nil
  "Literate LFE support."
  :group 'lisp
  :group 'languages)

(defvar llfe-classes-alist
  '((llfe-erlang
     :submode erlang-mode
     :face mmm-default-submode-face
     :front "^```{\\.erlang.*}[\n\r]+"
     :back "^```$")
    (llfe-fish
     :submode fish-mode
     :face mmm-default-submode-face
     :front "^```{\\.fish.*}[\n\r]+"
     :back "^```$")
    (llfe-lfe
     :submode lfe-mode
     :face mmm-default-submode-face
     :front "^```{\\.lfe.*}[\n\r]+"
     :back "^```$")
    (llfe-sh
     :submode sh-mode
     :face mmm-default-submode-face
     :front "^```{\\.\\(?:ba\\)sh.*}[\n\r]+"
     :back "^```$")
    (llfe-text
     :submode text-mode
     :face mmm-default-submode-face
     :front "^```{\\.text.*}[\n\r]+"
     :back "^```$"))
  "LLFE-specific `mmm-classes-alist'.")

(defvar llfe-mode-ext-classes-alist
  (mapcar (lambda (submode) `(llfe-mode "\\.llfe\\'" ,submode))
          (mapcar 'car llfe-classes-alist))
  "LLFE-specific `mmm-mode-ext-classes-alist'.")

;;;###autoload
(define-derived-mode llfe-mode markdown-mode "LLFE"
  "Major mode for editing LLFE (Literate Lisp Flavoured Erlang)."
  :syntax-table nil
  :abbrev-table nil
  (make-local-variable 'mmm-classes-alist)
  (setq mmm-classes-alist (append mmm-classes-alist llfe-classes-alist))
  (make-local-variable 'mmm-mode-ext-classes-alist)
  (setq mmm-mode-ext-classes-alist
        (append mmm-mode-ext-classes-alist llfe-mode-ext-classes-alist))
  (set (make-local-variable 'mmm-submode-decoration-level) 2))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.llfe\\'" . llfe-mode))

(provide 'llfe-mode)
;;; llfe-mode.el ends here
