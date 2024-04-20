(defpackage cled
  (:use :cl))
(in-package :cled)

(defvar *BUFFERS* '())

;; (defun main ()
;;   (let (enter) (setq enter (read-line))
;;     (print enter)))

(defun create-buffer (name path contents)
  (push (list :name name :path path :contents contents) *BUFFERS*))

(defun load-file (&key lazy)
  (let ((file-path "") (file-lines ""))
    (if (not lazy) (setq file-lines (uiop:read-file-string file-path)))
    (setq file-path (uiop:native-namestring (read-line))) ;; TODO: throw error if invalid path
    (create-buffer (file-namestring file-path) file-path file-lines)))

(defun load-file--string-list ()
  (let (file-path file-lines)
    (setq file-path (uiop:native-namestring (read-line)))
    (setq file-lines (uiop:read-file-lines file-path))
    (create-buffer (file-namestring file-path) file-path file-lines)
    (print file-lines)))


(defun get-buffer (select-fun)
  (remove-if-not select-fun *BUFFERS*))

(defun make-comparison-expr (field value)
  `(equal (getf cd ,field) ,value))

(defun make-comparisons-list (fields)
  (loop while fields
	collecting (make-comparison-expr (pop fields) (pop fields))))

(defmacro where (&rest clauses)
  `#'(lambda (cd) (and ,@(make-comparisons-list clauses))))


(defun buffer-update (buffer &key name path contents) ;; maybe pass selector-fun instead of buffer
  (if name (setf (getf buffer :name) name))
  (if path (setf (getf buffer :path) path))
  (if contents (setf (getf buffer :contents) contents)))

;; (load-file) ~/quicklisp/local-projects/cled/rope.py
;; (getf (nth 1 cled::*BUFFERS*) :name) ;; "rope.py"
;; (subseq (getf (nth 1 cled::*BUFFERS*) :contents) 0 10)
;; (getf (nth 0 (cled::get-buffer (cled::where :name "rope.py"))) :name) ;; "rope.py"

(defun write-contents (buffer)
  (let ((file (getf buffer :path)))
    (with-open-file (out file
		       :direction :output
		       :if-exists :supersede)
    (with-standard-io-syntax
      (write-sequence (getf buffer :contents) out)))))

(defun write-contents--string-list (buffer)
  (let ((file (getf buffer :path)))
    (with-open-file (out file
		       :direction :output
		       :if-exists :supersede)
      (with-standard-io-syntax
	(dolist (line (getf buffer :contents))
	  (write-sequence  out))))))

;; try to use for ncurses?
;; (ql:quickload "croatoan")


;; blah blah blah.

