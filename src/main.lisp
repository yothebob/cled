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

;; try to use for ncurses?
;; (ql:quickload "croatoan")

