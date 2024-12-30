(defpackage cled
  (:use :cl))
(in-package :cled)

(defun make-comparison-expr (field value)
  `(equal (getf cd ,field) ,value))

(defun make-comparisons-list (fields)
  (loop while fields
	collecting (make-comparison-expr (pop fields) (pop fields))))

(defmacro where (&rest clauses)
  `#'(lambda (cd) (and ,@(make-comparisons-list clauses))))

(defun write-contents (buffer)
  (let ((file (getf buffer :path)))
    (print (getf buffer :path))
    (with-open-file (out file
		       :direction :output
		       :if-exists :supersede)
      (with-standard-io-syntax
	(dolist (line (getf buffer :contents))
	  (write-sequence line out)
	  (write-char #\return out)
	  (write-char #\linefeed out))))))
(defun terminal-stream ()
  (let ((cmd ""))
  (loop while (not (string-equal cmd "exit")) do
	      (progn
		(format *query-io* "~a: " "cmd")
		(finish-output *query-io*)
		(setq cmd (read-line *query-io*))
		;; TODO: add some more conds, add function aliases  
		(if (not (string= cmd "exit"))
		(if (string= cmd "hello")
		    (princ (concatenate 'string "hello " (uiop:getenv "USER") "!" '(#\Newline)))
		    (eval (read-from-string cmd))))))))
;; try to use for ncurses?
;; (ql:quickload "croatoan")

;; user input stream
;; (let ((cmd ""))
;;   (loop while (not (string-equal cmd "exit")) do
;; 	      (progn
;; 		(format *query-io* "~a: " "cmd")
;; 		(finish-output *query-io*)
;; 		(setq cmd (read-line *query-io*))
;; 		(if (string= cmd "hello")
;; 		    (princ (concatenate 'string "hello " (uiop:getenv "USER") "!" '(#\Newline))))
;; 		)))
