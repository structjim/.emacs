(custom-set-faces '(default((t(:family "Comic Code" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))

;;Visit .emacs file (Decalred early so I can still call it when there are errors in this file.)
(defun ii () "Opens the .emacs initialization file." (interactive)
       (find-file "~/.emacs")
	   )
;;Update .emacs from web (Emacs restart or manual eval required after.)
(defun uu () "Update .emacs file" (interactive)
	   (browse-url-emacs "https://raw.githubusercontent.com/zyusouken/dotEmacs/main/.emacs")
	   (write-file "~/.emacs")
	   (kill-this-buffer)
	   )

(defvar jims-keys-minor-mode-map
	(let ((map (make-sparse-keymap)))
;;;;(define-key map (kbd "C-i") 'some-function)
	(define-key map (kbd "C-d") 'dupe-line)
	(define-key map (kbd "M-d") 'dupe-line-prompt)
	(define-key map (kbd "M-c") 'insert-comment-block)
	map)
	"jims-keys-minor-mode keymap."
)
(define-minor-mode jims-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " jims-keys"
)
(jims-keys-minor-mode 1)

;;;;;;;;;;;;;;;;;;
;;   KEYBINDS   ;;
;;;;;;;;;;;;;;;;;;
;;I use Pause for whatever weird command I'm trying out at the moment.
(define-key global-map [pause] (setq mark-active t))
;;No screwing with my middle mouse button (TODO: Maybe make it paste later.)
(global-unset-key [mouse-2])
;;[TRANSLATIONS]
;;Switch C-x&C-c and C-o&C-p to get Windows-like copy paste behavior
;;without having to un/rebind every built-in C-o and C-c binding.
;;(This is probably a capital Emacs crime. Don't care!)
(keyboard-translate ?\C-x ?\C-o)
(keyboard-translate ?\C-o ?\C-x)
(keyboard-translate ?\C-c ?\C-p)
(keyboard-translate ?\C-p ?\C-c)
;;[EDITING]
(global-set-key (kbd "<backspace>") 'my-delete-indentation)
(global-set-key (kbd "C-w") 'windows-revert)
(global-set-key (kbd "C-o") 'kill-region) ;;CUT, TRANSLATED TO C-x
(global-set-key (kbd "C-p") 'kill-ring-save) ;;COPY, TRANSLATED C-c
(global-set-key (kbd "C-v") 'clipboard-yank)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-S-f") 'isearch-backward)
(global-set-key (kbd "TAB") 'tab-to-tab-stop) ;;NPP-style tabbing
(define-key global-map [C-up] 'previous-blank-line)
(define-key global-map [C-down] 'next-blank-line)
(define-key global-map [C-right] 'forward-whitespace)
(define-key global-map [C-left] (lambda () (interactive) (forward-whitespace -1)))
(define-key global-map (kbd "C-S-<up>") (lambda () (interactive) (move-lines -1)))
(define-key global-map (kbd "C-S-<down>") (lambda () (interactive) (move-lines 1)))
(define-key global-map [M-up] (lambda () (interactive) (scroll-down 6)))
(define-key global-map [M-down] (lambda () (interactive) (scroll-up 6)))
(define-key global-map [M-left] 'back-to-indentation)
(define-key global-map [M-right] 'move-end-of-line)
(define-key global-map [home] 'beginning-of-line)
(define-key global-map [end] 'end-of-line)
(define-key global-map [pgup] 'forward-page)
(define-key global-map [pgdown] 'backward-page)
(define-key global-map [C-next] 'scroll-other-window)
(define-key global-map [C-prior] 'scroll-other-window-down)
(define-key global-map [backtab] 'indent-for-tab-command)
(define-key global-map [C-tab] 'indent-region)
(define-key global-map "\er" 'query-replace)
(global-set-key (kbd "C-r") 'rainbow-delimiters-mode) ;;Rainbow Delimiters Toggle
;;[WINDOWING]
(define-key global-map "\ew" 'other-window)
;;[BUFFERS AND FILES]
(global-set-key (read-kbd-macro "\eb") 'next-buffer)
(global-set-key (read-kbd-macro "\eB") 'previous-buffer)
(global-set-key (read-kbd-macro "\ev") 'jim-vim)
(define-key global-map "\ek" 'kill-this-buffer)
(define-key global-map "\es" 'save-buffer)
(define-key global-map "\C-s" 'save-buffer)
(define-key global-map (kbd "M-<f4>") 'kill-emacs)
;;[FINDING FILES TO VISIT]
(define-key global-map "\ef" 'find-file)
(define-key global-map "\eF" 'find-file-other-window)
;;[RANDOM FUN]
(define-key global-map "\ep" 'quick-calc)
(define-key global-map "\eq" 'describe-function) ;;HELP
(define-key global-map "\eQ" 'describe-variable) ;;HELP 2: The Squeakquel

;;;;;;;;;;;;;;;;;;;;
;;      INIT      ;;
;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
	'(kept-new-versions 6)
	'(kept-old-versions 6)
	'(visible-bell t)
	'(show-paren-mode t)
	'(ring-bell-function (quote ignore))
	)

;;[SYSTEM AND NAVIGATION]
(global-display-line-numbers-mode t)
;;(setq display-line-numbers-type 'relative)
(add-to-list 'default-frame-alist '(fullscreen . maximized));;Maximize
(setq-default truncate-lines t);;Lines run off the page. Otherwise relative nums freak out.
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(display-time)
(setq blink-cursor-delay 0);;Start blinking immediately
(setq blink-cursor-blinks 0);;0 means infinite blinks
(setq blink-cursor-interval 0.0666);;Maniacally fast
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)));;One line at a time
(setq mouse-wheel-progressive-speed nil);;Don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't);;Scroll window under mouse
(setq scroll-step 3);;From Casey's config; Do I even need this anymore?
;;[INDENTING AND TABS]
(setq c-default-style "bsd"  c-basic-offset 4)
(setq c-offsets-alist '((arglist-intro . +)))
(c-set-offset 'substatement-open 0) ;;Makes looks indent correctly
(electric-indent-mode t);;No forced indenting
(setq-default indent-tabs-mode t)
(setq-default tab-width 4);;4 spaces wide
(defvaralias 'c-basic-offset 'tab-width)
;;[EDITING]
(set-language-environment "UTF-8")
(setq Undo-Limit 20000000)
(setq Undo-Strong-Limit 40000000)
(add-hook 'emacs-lisp-mode-hook (lambda()(setq indent-tabs-mode t)));;use tabs in elisp too
(delete-selection-mode 1);;Typing deletes region
;;Stuff from Casey that I don't understand yet (but have for some reason)
(setq next-line-add-newlines nil)
(setq truncate-partial-width-windows nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      FUNCTIONS AND TOOLS      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun pause-test-fun () 
	"Just do whatever you want here and it'll map to [Pause]." 
	(interactive) 
	(if (use-region-p)
		(insert "YES")
		(insert "NO")
	)
)
(defun fr () "query-replace" (interactive) 'query-replace);;"Find replace"
(defun previous-blank-line ()
  "Move cursor to the previous line that is empty or contains only whitespace characters."
  (interactive)
  (forward-line -1)
  (while (and (not (bobp))
              (not (looking-at-p "^\\s-*$")))
    (forward-line -1))
)
(defun next-blank-line ()
  "Move cursor to the next line that is empty or contains only whitespace characters."
  (interactive)
  (forward-line 1)
  (while (and (not (eobp))
              (not (looking-at-p "^\\s-*$")))
    (forward-line 1))
)
(defun expand-region ()
	"Expands region to fully engulf affected line(s). Helps implement dupe-line."
	(interactive)
	(if (not(use-region-p))
		;;Handles wild marks if region is inactive
		(set-mark (point))
	)
	(if (< (point) (mark))
		;;Make sure point isn't before mark
		(exchange-point-and-mark)
	)
	(let
		(
			(end (line-end-position))
		)
		(exchange-point-and-mark)
		;;Nested let so we can flip in between declarations.
		(let
			(
				(beg (line-beginning-position))
			)
			(goto-char beg)
			(push-mark end t t)
			(setq deactivate-mark nil)
			(exchange-point-and-mark)
		)
	)
)
(defun dupe-line (&optional n)
	"Duplicate current line n times. n defaults to 1."
	(interactive "p")
	(save-excursion
		(let
			(
				(old-kill (current-kill 0 t))
			)
			(expand-region)
			(kill-region (point) (mark))
			(yank) ;;At least once.
			(dotimes (_ n) (newline)(yank) ) ;;Then add dupes.
			;;Restore old
			(kill-new old-kill)
		)
	)
)
(defun dupe-line-prompt (&optional count)
  "Duplicate the current line COUNT times."
  (interactive "p")
  (let ((user-input (string-to-number(read-from-minibuffer "Enter a value: "))))
	(dupe-line user-input)
	)
)
(defun insert-comment-block ()
	"Inserts /**/ and moves the cursor between the asterisks."
	(interactive)
	(insert "/**/")
	(backward-char 2)
)
;;Stop backspacing tabs partially
(defun my-delete-indentation ()
	"Delete indentation or a tab character before point."
	(interactive)
	(if (looking-back "\t*\\( +\\)$" nil)
		(backward-delete-char 1)
		(call-interactively 'backward-delete-char))
)
(defun ww ()
	"Default to default view, split horizontally."
	(interactive)
	(delete-other-windows)
	(split-window-horizontally)
)

;;;;;;;;;;;;;;;;;;;;;;
;;   EXPERIMENTAL   ;;
;;;;;;;;;;;;;;;;;;;;;;
(defun spready () (interactive)
	   ;;START
	   (let ((spready_delimiter "^"))
		 ;;Kill stuff before table
		 (beginning-of-buffer)
		 (set-mark (point))
		 (search-forward "Course Dates Amount" nil t)
		 (next-line)
		 (beginning-of-line)
		 (kill-region (point)(mark))
		 ;;Kill stuff after table
		 (end-of-buffer)
		 (set-mark (point))
		 (search-backward "Total" nil t)
		 (backward-char 1)
		 (kill-region (point)(mark))
		 (deactivate-mark)
		 (beginning-of-buffer)
		 (while (not (eobp)) ;;Per record...
		 (delete-char 8)
		 (end-of-line)
		 ;;Truncate cost
		 (search-backward " " nil t)
		 (kill-line)
		 ;;delimiter before each of the 2 date
		 (search-backward " " nil t 2)
		 (delete-char 3)
		 (insert spready_delimiter)
		 (search-backward " " nil t)
		 (delete-char 1)
		 (insert spready_delimiter)
		 ;;delimiter before TRAINING
		 (search-backward " " nil t)
		 (delete-char 1)
		 (insert spready_delimiter)
		 ;;delimiter after name
		 (search-backward "@" nil t)
		 (search-backward " " nil t)
		 (delete-char 1)
		 (insert spready_delimiter)
		 ;;delimiter after email
		 (search-forward " " nil t)
		 (delete-backward-char 1)
		 (insert spready_delimiter)
		 ;;Delete comma and space separating LAST, FIRSTMIDDLE
		 (beginning-of-line)
		 (search-forward "," nil t)
		 (backward-char 1)
		 (delete-char 2)
		 ;;Cut last name
		 (set-mark (point))
		 (beginning-of-line)
		 (kill-region (point) (mark))
		 (deactivate-mark)	
		 ;;Move last name after FIRSTMIDDLE
		 (search-forward spready_delimiter nil t)
		 (backward-char 1)
		 (insert " ")
		 (yank)
		 ;;Done with this record.
		 (forward-line)
		 ))
		 (beginning-of-buffer))

(defun maily () (interactive)
	   ;;START
	   (let ((maily_delimiter "^"))
		 ;;Delete before firstname
		 (end-of-buffer)
		 (newline)
		 (push-mark)
		 (yank)
		 (pop-global-mark)
		 (search-forward "firstname - " nil t)
		 (kill-region (point) (mark))
		 ;;Delete between names, leavea a space
		 (end-of-line)
		 (set-mark (point))
		 (search-forward "lastname -" nil t)
		 (kill-region (point) (mark))
		 ;;Delimiter after names
		 (end-of-line)
		 (insert maily_delimiter)
		 ;;Delete stuff between names delimiter and mail
		 (set-mark (point))
		 (search-forward "emailaddress - " nil t)
		 (kill-region (point) (mark))
		 ;;Delimiter after mail
		 (end-of-line)
		 (insert maily_delimiter)
		 ;;Delete stuff between mail and phone
		 (set-mark (point))
		 (search-forward "phonenumber - " nil t)
		 (kill-region (point) (mark))
		 ;;Delete the rest
		 (end-of-line)
		 (set-mark (point))
		 (end-of-buffer)
		 (kill-region (point) (mark))))

(defun jim-vim (input)
	"Handle Vim-like up/down jumps with just an int."
	(interactive "sEnter Vim movement: ")
	(let ((count (string-to-number input)))
		(cond
		((> count 0) (next-line count))
		((< count 0) (previous-line (- count)))
		(t (message "Invalid movement: %s (enter a signed int)" input)))
	)
)

(defun jim-vim-jk (input)
	"Handle Vim-like Nj and Nk movements based on the input."
	(interactive "sEnter Vim movement: ")
	(cond
	((string-match "^\\([0-9]+\\)j$" input)
	(let ((count (string-to-number (match-string 1 input))))
		(next-line count)))
	((string-match "^\\([0-9]+\\)k$" input)
	(let ((count (string-to-number (match-string 1 input))))
		(previous-line count)))
	(t
	(message "Invalid Vim movement: %s (Note that we only support j and k)" input)))
)
(defun move-lines (n)
	(interactive "p")
	"Move the current line up or down by n lines."
	(let ((used-region (use-region-p)))
			(expand-region);;Selects whole line(s), excluding final \n
			(kill-region (point)(mark));;Leaves 1 empty line
			(delete-char 1);;Delete empty line
			(forward-line n)
			(yank)(newline)
			(backward-char 1)
			(if used-region
				(progn
					(end-of-line)
					(setq deactivate-mark nil)
					(setq mark-active t)
				)
			)
	)
)
(defun windows-revert ()
	"Revert view to two windows, split horizontally."
	(interactive)
	(delete-other-windows)
	(split-window-horizontally)
)

;;[FROM CASEY]
;;Bright-red TODOs
(setq fixme-modes '(c++-mode c-mode emacs-lisp-mode))
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-study-face)
(make-face 'font-lock-important-face)
(make-face 'font-lock-note-face)
(mapc (lambda (mode)
	(font-lock-add-keywords
	mode
	'(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
	("\\<\\(STUDY\\)" 1 'font-lock-study-face t)
	("\\<\\(IMPORTANT\\)" 1 'font-lock-important-face t)
	("\\<\\(NOTE\\)" 1 'font-lock-note-face t)))
	)
	fixme-modes
)
(modify-face 'font-lock-fixme-face "Red" nil nil t nil t nil nil)
(modify-face 'font-lock-study-face "Yellow" nil nil t nil t nil nil)
(modify-face 'font-lock-important-face "Yellow" nil nil t nil t nil nil)
(modify-face 'font-lock-note-face "Dark Green" nil nil t nil t nil nil)

;;[Jim's tweaks:]
;;This makes binary literals (EG: 0b10001010) orange.
;;I got some AI help, so it might be weird. But it works!
(setq jims-syntax-color-modes '(c++-mode c-mode emacs-lisp-mode))
(make-face 'font-lock-binaryliteral-face)
(mapc (lambda (mode)
	(font-lock-add-keywords
	mode
	'(("\\b0b\\([01]+\\)\\b" 0 'font-lock-binaryliteral-face)))
	;'(("\\b0b\\([01]+\\)\\b" 1 'font-lock-binaryliteral-face)))
	)
	jims-syntax-color-modes
)
(set-face-attribute 'font-lock-binaryliteral-face nil :foreground "orange")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Jim's color scheme      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun colors-jim () "Switches to Jim's color scheme." (interactive)
	(custom-set-faces
		'(default ((t (:foreground "ivory2" :background "#343036"))))
		'(custom-group-tag-face ((t (:underline t :foreground "black"))) t)
		'(custom-variable-tag-face ((t (:underline t :foreground "black"))) t)
		'(font-lock-builtin-face ((t (:foreground "wheat4"))))
		'(font-lock-comment-face ((t (:foreground "#00ff00"))))
		'(font-lock-constant-face ((t (:foreground "wheat4"))))
		'(font-lock-function-name-face ((((class color) (background dark)) (:foreground "white"))))
		'(font-lock-keyword-face ((t (:foreground "OrangeRed1" ))))
		'(font-lock-string-face ((t (:foreground "cyan1"))))
		'(font-lock-type-face ((t (:foreground "yellow2"))))
		'(font-lock-variable-name-face ((t (:foreground "MediumOrchid1"))));;c8d4ec
		'(font-lock-warning-face ((t (:foreground "red1"))))
		'(mode-line ((t (:inverse-video t))))
		'(region ((t (:background "black"))))
		'(widget-field-face ((t (:foreground "white"))) t)
		'(widget-single-line-field-face ((t (:background "darkgray"))) t)
	)
	(global-font-lock-mode 1)
    (set-cursor-color "lightgreen")
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Jon Blow's color scheme      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;I should have the original archived with notes somewhere...
(defun colors-jon () "Switches to Jon Blow's color scheme." (interactive)
	(custom-set-faces
		'(default ((t (:foreground "#d3b58d" :background "#041818"))))
		'(custom-group-tag-face ((t (:underline t :foreground "lightblue"))) t)
		'(custom-variable-tag-face ((t (:underline t :foreground "lightblue"))) t)
		'(font-lock-builtin-face ((t nil)))
		;; '(font-lock-comment-face ((t (:foreground "yellow"))))
		'(font-lock-comment-face ((t (:foreground "#3fdf1f"))))
		'(font-lock-function-name-face ((((class color) (background dark)) (:foreground "white"))))
		'(font-lock-keyword-face ((t (:foreground "white" ))))
		;; '(font-lock-string-face ((t (:foreground "gray160" :background "gray16"))))
		'(font-lock-string-face ((t (:foreground "#0fdfaf"))))
		'(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "#c8d4ec"))))  
		;; '(font-lock-warning-face ((t (:foreground "#695a46"))))
		'(font-lock-warning-face ((t (:foreground "#504038"))))
		'(highlight ((t (:foreground "navyblue" :background "darkseagreen2"))))
		'(mode-line ((t (:inverse-video t))))
		'(region ((t (:background "blue"))))
		'(widget-field-face ((t (:foreground "white"))) t)
		'(widget-single-line-field-face ((t (:background "darkgray"))) t)
	)
	(global-font-lock-mode 1)
	(set-cursor-color "lightgreen")
	(set-background-color "#072626")
	(global-set-key [C-return] 'save-buffer)
	(set-face-foreground 'font-lock-builtin-face         "lightgreen")
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Default theme      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(colors-jim)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      Final setup      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(split-window-horizontally);;Just 1 split to get us started



;;Everything below this line is for Rainbow Delimiters.
;;https://github.com/Fanael/rainbow-delimiters/tree/master
;;It's a lot of code, so I keep it separated with this huge comment block. -Jim
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;; ;;   RAINBOW DELIMITERS  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;https://github.com/Fanael/rainbow-delimiters/tree/master
(defgroup rainbow-delimiters nil
  "Highlight nested parentheses, brackets, and braces according to their depth."
  :prefix "rainbow-delimiters-"
  :link '(url-link :tag "Website for rainbow-delimiters"
                   "https://github.com/Fanael/rainbow-delimiters")
  :group 'applications)
(defgroup rainbow-delimiters-faces nil
  "Faces for successively nested pairs of delimiters.
When depth exceeds innermost defined face, colors cycle back through."
  :group 'rainbow-delimiters
  :group 'faces
  :link '(custom-group-link "rainbow-delimiters")
  :prefix "rainbow-delimiters-")
(defcustom rainbow-delimiters-pick-face-function
  #'rainbow-delimiters-default-pick-face
  "The function used to pick a face used to highlight a delimiter.
The function should take three arguments (DEPTH MATCH LOC), where:
  - DEPTH is the delimiter depth; when zero or negative, it's an unmatched
    delimiter.
  - MATCH is nil iff the delimiter is a mismatched closing delimiter.
  - LOC is the location of the delimiter.
The function should return a value suitable to use as a value of the `face' text
property, or nil, in which case the delimiter is not highlighted.
The function should not move the point or mark or change the match data."
  :tag "Pick face function"
  :type 'function
  :group 'rainbow-delimiters)
(defface rainbow-delimiters-base-face
  '((default (:inherit unspecified)))
  "Face inherited by all other rainbow-delimiter faces."
  :group 'rainbow-delimiters-faces)
(defface rainbow-delimiters-base-error-face
  '((default (:inherit rainbow-delimiters-base-face))
    (t (:foreground "#88090B")))
  "Face inherited by all other rainbow-delimiter error faces."
  :group 'rainbow-delimiters-faces)
(defface rainbow-delimiters-unmatched-face
  '((default (:inherit rainbow-delimiters-base-error-face)))
  "Face to highlight unmatched closing delimiters in."
  :group 'rainbow-delimiters-faces)
(defface rainbow-delimiters-mismatched-face
  '((default (:inherit rainbow-delimiters-unmatched-face)))
  "Face to highlight mismatched closing delimiters in."
  :group 'rainbow-delimiters-faces)
(eval-when-compile
  (defmacro rainbow-delimiters--define-depth-faces ()
    (let ((faces '())
          (light-colors ["#707183" "#7388d6" "#909183" "#709870" "#907373"
                         "#6276ba" "#858580" "#80a880" "#887070"])
          (dark-colors ["grey55" "#93a8c6" "#b0b1a3" "#97b098" "#aebed8"
                        "#b0b0b3" "#90a890" "#a2b6da" "#9cb6ad"]))
      (dotimes (i 9)
        (push `(defface ,(intern (format "rainbow-delimiters-depth-%d-face" (1+ i)))
                 '((default (:inherit rainbow-delimiters-base-face))
                   (((class color) (background light)) :foreground ,(aref light-colors i))
                   (((class color) (background dark)) :foreground ,(aref dark-colors i)))
                 ,(format "Nested delimiter face, depth %d." (1+ i))
                 :group 'rainbow-delimiters-faces)
              faces))
      `(progn ,@faces))))
(rainbow-delimiters--define-depth-faces)
(defcustom rainbow-delimiters-max-face-count 9
  "Number of faces defined for highlighting delimiter levels.
Determines depth at which to cycle through faces again.
It's safe to change this variable provided that for all integers from 1 to the
new value inclusive, a face `rainbow-delimiters-depth-N-face' is defined."
  :type 'integer
  :group 'rainbow-delimiters)
(defcustom rainbow-delimiters-outermost-only-face-count 0
  "Number of faces to be used only for N outermost delimiter levels.
This should be smaller than `rainbow-delimiters-max-face-count'."
  :type 'integer
  :group 'rainbow-delimiters)
(defun rainbow-delimiters-default-pick-face (depth match _loc)
  "Return a face name appropriate for nesting depth DEPTH.
DEPTH and MATCH are as in `rainbow-delimiters-pick-face-function'.
The returned value is either `rainbow-delimiters-unmatched-face',
`rainbow-delimiters-mismatched-face', or one of the
`rainbow-delimiters-depth-N-face' faces, obeying
`rainbow-delimiters-max-face-count' and
`rainbow-delimiters-outermost-only-face-count'."
  (cond
   ((<= depth 0)
    'rainbow-delimiters-unmatched-face)
   ((not match)
    'rainbow-delimiters-mismatched-face)
   (t
    (intern-soft
     (concat "rainbow-delimiters-depth-"
             (number-to-string
              (if (<= depth rainbow-delimiters-max-face-count)
                  ;; Our nesting depth has a face defined for it.
                  depth
                ;; Deeper than # of defined faces; cycle back through to
                ;; `rainbow-delimiters-outermost-only-face-count' + 1.
                ;; Return face # that corresponds to current nesting level.
                (+ 1 rainbow-delimiters-outermost-only-face-count
                   (mod (- depth rainbow-delimiters-max-face-count 1)
                        (- rainbow-delimiters-max-face-count
                           rainbow-delimiters-outermost-only-face-count)))))
             "-face")))))
(defun rainbow-delimiters--apply-color (loc depth match)
  "Highlight a single delimiter at LOC according to DEPTH.
LOC is the location of the character to add text properties to.
DEPTH is the nested depth at LOC, which determines the face to use.
MATCH is nil iff it's a mismatched closing delimiter."
  (let ((face (funcall rainbow-delimiters-pick-face-function depth match loc)))
    (when face
      (font-lock-prepend-text-property loc (1+ loc) 'face face))))
(defun rainbow-delimiters--char-ineligible-p (loc ppss delim-syntax-code)
  "Return t if char at LOC should not be highlighted.
PPSS is the `parse-partial-sexp' state at LOC.
DELIM-SYNTAX-CODE is the `car' of a raw syntax descriptor at LOC.
Returns t if char at loc meets one of the following conditions:
- Inside a string.
- Inside a comment.
- Is an escaped char, e.g. ?\)"
  (or
   (nth 3 ppss)                ; inside string?
   (nth 4 ppss)                ; inside comment?
   (nth 5 ppss)                ; escaped according to the syntax table?
   ;; Note: no need to consider single-char openers, they're already handled
   ;; by looking at ppss.
   (cond
    ;; Two character opener, LOC at the first character?
    ((/= 0 (logand #x10000 delim-syntax-code))
     (/= 0 (logand #x20000 (or (car (syntax-after (1+ loc))) 0))))
    ;; Two character opener, LOC at the second character?
    ((/= 0 (logand #x20000 delim-syntax-code))
     (/= 0 (logand #x10000 (or (car (syntax-after (1- loc))) 0))))
    (t
     nil))))
;; Main function called by font-lock.
(defun rainbow-delimiters--propertize (end)
  "Highlight delimiters in region between point and END.
Used by font-lock for dynamic highlighting."
  (when (bound-and-true-p mmm-current-submode)
    ;; `mmm-mode' is weird and apparently needs this hack, because otherwise we
    ;; may end up thinking matched parentheses are mismatched.
    (widen))
  (let* ((last-ppss-pos (point))
         (ppss (syntax-ppss)))
    (while (> end (progn (skip-syntax-forward "^()" end)
                         (point)))
      (let* ((delim-pos (point))
             (delim-syntax (syntax-after delim-pos)))
        (setq ppss (parse-partial-sexp last-ppss-pos delim-pos nil nil ppss))
        (setq last-ppss-pos delim-pos)
        ;; `skip-syntax-forward' leaves the point at the delimiter, move past
        ;; it.
        (forward-char)
        (let ((delim-syntax-code (car delim-syntax)))
          (cond
           ((rainbow-delimiters--char-ineligible-p delim-pos ppss delim-syntax-code)
            nil)
           ((= 4 (logand #xFFFF delim-syntax-code))
            ;; The (1+ ...) is needed because `parse-partial-sexp' returns the
            ;; depth at the opening delimiter, not in the block being started.
            (rainbow-delimiters--apply-color delim-pos (1+ (nth 0 ppss)) t))
           (t
            ;; Not an opening delimiter, so it's a closing delimiter.
            (let ((matches-p (eq (cdr delim-syntax) (char-after (nth 1 ppss)))))
              (rainbow-delimiters--apply-color delim-pos (nth 0 ppss) matches-p))))))))
  ;; We already fontified the delimiters, tell font-lock there's nothing more
  ;; to do.
  nil)
;; NB: no face defined here because we apply the faces ourselves instead of
;; leaving that to font-lock.
(defconst rainbow-delimiters--font-lock-keywords
  '(rainbow-delimiters--propertize))
;;;###autoload
(define-minor-mode rainbow-delimiters-mode
  "Highlight nested parentheses, brackets, and braces according to their depth."
  :init-value nil
  :lighter "" ; No modeline lighter - it's already obvious when the mode is on.
  :keymap nil
  (font-lock-remove-keywords nil rainbow-delimiters--font-lock-keywords)
  (when rainbow-delimiters-mode
    (font-lock-add-keywords nil rainbow-delimiters--font-lock-keywords 'append)
    (set (make-local-variable 'jit-lock-contextually) t)
    (when (or (bound-and-true-p syntax-begin-function)
              (bound-and-true-p font-lock-beginning-of-syntax-function))
      ;; We're going to modify `syntax-begin-function', so flush the cache to
      ;; avoid getting cached values that used the old value.
      (syntax-ppss-flush-cache 0))
    ;; `syntax-begin-function' may break the assumption we rely on that
    ;; `syntax-ppss' is exactly equivalent to `parse-partial-sexp' from
    ;; `point-min'. Just don't use it, the performance hit should be negligible.
    (when (boundp 'syntax-begin-function)
      (set (make-local-variable 'syntax-begin-function) nil))
    ;; Obsolete equivalent of `syntax-begin-function'.
    (when (boundp 'font-lock-beginning-of-syntax-function)
      (set (make-local-variable 'font-lock-beginning-of-syntax-function) nil)))
  (when font-lock-mode
    (if (fboundp 'font-lock-flush)
        (font-lock-flush)
      (with-no-warnings (font-lock-fontify-buffer)))))
;;;###autoload
(defun rainbow-delimiters-mode-enable ()
  "Enable `rainbow-delimiters-mode'."
  (rainbow-delimiters-mode 1))
;;;###autoload
(defun rainbow-delimiters-mode-disable ()
  "Disable `rainbow-delimiters-mode'."
  (rainbow-delimiters-mode 0))
(provide 'rainbow-delimiters)
(custom-set-faces
	'(rainbow-delimiters-depth-1-face ((t (:foreground "ivory2"))));Default
	'(rainbow-delimiters-depth-2-face ((t (:foreground "red"))))
	'(rainbow-delimiters-depth-3-face ((t (:foreground "darkorange"))))
	'(rainbow-delimiters-depth-4-face ((t (:foreground "gold"))))
	'(rainbow-delimiters-depth-5-face ((t (:foreground "mediumseagreen"))))
	'(rainbow-delimiters-depth-6-face ((t (:foreground "royalblue"))))
	'(rainbow-delimiters-depth-7-face ((t (:foreground "MediumOrchid1"))))
	'(rainbow-delimiters-depth-8-face ((t (:foreground "dimgray"))))
	'(rainbow-delimiters-depth-9-face ((t (:foreground "black"))))
	'(rainbow-delimiters-unmatched-face ((t (:foreground "white" :background "red"))))
	'(rainbow-delimiters-mismatched-face ((t (:foreground "white" :background "red"))))
)
