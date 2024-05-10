(defpackage cled
  (:use :cl))
(in-package :cled)

(defvar *BUFFERS* '())

(defun create-buffer (name path contents)
  (push (list :name name :path path :contents contents) *BUFFERS*))

(defun load-file ()
  (let (file-path file-lines)
    (setq file-path (uiop:native-namestring (read-line)))
    (setq file-lines (uiop:read-file-lines file-path))
    (create-buffer (file-namestring file-path) file-path file-lines)))

(defun get-buffer (select-fun &key buffer-index)
  ;; TODO: impliment buffer-index so if there are multiple, user can select one buffer-index
  (car (remove-if-not select-fun *BUFFERS*)))

(defun make-comparison-expr (field value)
  `(equal (getf cd ,field) ,value))

(defun make-comparisons-list (fields)
  (loop while fields
	collecting (make-comparison-expr (pop fields) (pop fields))))

(defmacro where (&rest clauses)
  `#'(lambda (cd) (and ,@(make-comparisons-list clauses))))

(defun buffer-update (buffer &key name path contents) ;; maybe pass selector-fun instead of buffer
;; TODO: this function could be cleaned up alot
  (if name (setf (getf buffer :name) name))
  (if path (setf (getf buffer :path) path))
  (if contents (setf (getf buffer :contents) contents)))

(defun update-buffer-line (buffer &key line contents write)
  (let ((buffer buffer) (contents contents))
    (if (not contents) (setq contents (read-line)))
    (setf (nth line (getf buffer :contents)) contents)
    (if write (cled::write-contents buffer))))

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

