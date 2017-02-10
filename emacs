(require 'package)

;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(require 'evil)
(evil-mode 1)

;; opining files




; publish to html
(setq org-export-html-style-include-scripts nil
      org-export-html-style-include-default nil)

(setq org-export-html-style
   "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/stylesheet.css\" />")
(require 'ox-publish)

(setq org-publish-project-alist
      '(
	
("notes-org"
 :base-directory "~/nextcloud/notes"
 :base-extension "org"
 :publishing-directory "~/nextcloud/wiki/notes"
 :recursive t
 :publishing-function org-html-publish-to-html
 :headline-levels 4             ; Just the default for this project.
 :auto-preamble t
 )	


("notes-static"
 :base-directory "~/nextcloud/notes/"
 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
 :publishing-directory "~/nextcloud/wiki/notes/"
 :recursive t
 :publishing-function org-publish-attachment
 )

("notes" :components ("notes-org" "notes-static"))




("semester-org"
 :base-directory "~/nextcloud/un/spring17/"
 :base-extension "org"
 :publishing-directory "~/nextcloud/wiki/un/spring17/"
 :recursive t
 :publishing-function org-html-publish-to-html
 :headline-levels 6
 :auto-preamble t
 :style "<link rel=\"stylesheet\" href=\"stylesheet.css\" type=\"text/css\" />"
 :with-toc nil
 )


("semester-static"
 :base-directory "~/nextcloud/un/spring17/"
 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
 :publishing-directory "~/nextcloud/wiki/un/spring17/"
 :recursive t
 :publishing-function org-publish-attachment
 )


("semester" :components ("semester-org" "semester-static"))

))






(require 'helm-config)

;; 
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)



;;;; org-mode:


;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)



;;;; Syntax highlighting 
(load-theme 'solarized-dark t)

;;;;spellcheck
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
;; fix spell check error on mac
(setq ispell-program-name "/usr/local/bin/aspell")
;;;;better looking indent
(setq org-startup-indented t)

;;;; place auto save files in tmp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; fontify code in code blocks
(setq org-src-fontify-natively t)

;;;; auto-complete 
;(require 'auto-complete)
;(require 'auto-complete-config)
;(ac-config-default)

;; make latex fragments bigger

(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

;; highlight lines that exceed a certain length
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)

(global-whitespace-mode +1) ;; Make it work everywhere



; bable

;; c and c++
(org-babel-do-load-languages
 'org-babel-load-languages '((C . t)))
; python
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; lisp
(org-babel-do-load-languages
 'org-babel-load-languages
 '((lisp . t)))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)))

;; latex

(org-babel-do-load-languages
 'org-babel-load-languages
 '((latex . t)))








;; twitter boot strap

;(setq org-publish-project-alist
;      '(("org-notes"
 ;        :base-directory "~/nextcloud/notes/"
  ;       :publishing-directory "~/nextcloud/notes/html/"
   ;      :publishing-function org-twbs-publish-to-html
    ;     :with-sub-superscript nil
     ;    )))



(defun my-org-publish-buffer ()
  (interactive)
  (save-buffer)
  (save-excursion (org-publish-current-file))
  (let* ((proj (org-publish-get-project-from-filename buffer-file-name))
         (proj-plist (cdr proj))
         (rel (file-relative-name buffer-file-name
                                  (plist-get proj-plist :base-directory)))
         (dest (plist-get proj-plist :publishing-directory)))
    (browse-url (concat "file://"
                        (file-name-as-directory (expand-file-name dest))
                        (file-name-sans-extension rel)
                        ".html"))))






(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "s-\\") 'my-org-publish-buffer)))





; NeoTree


(add-to-list 'load-path "/home/m0/.emacs.d/source/neotree")
(require 'neotree)
;;(global-set-key [f8] 'neotree-toggle)
;;(global-set-key [f8] 'neotree-toggle)


;; Fix conflict with evil-mode

  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))







; display inline images

(setq org-startup-with-inline-images t)



; Switch alt with cmd if on mac

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil))









(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
