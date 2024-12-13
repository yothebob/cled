(in-package :cled)

(defvar *BUFFERS* '())
(defvar *CURRENT-BUFFER* nil)

(defun create-buffer (name path contents)
  (let ((name name) (buffer-quantity 0))
    (setq buffer-quantity (list-length (get-buffers (where :name name))))
    (if (> buffer-quantity 0)
	(setq name (format nil "~a<~a>" name (+ buffer-quantity 1))))
  (push (list :name name :path path :contents contents) *BUFFERS*)))

(defun load-file ()
  (let (file-path file-lines)
    (setq file-path (uiop:native-namestring (read-line)))
    (setq file-lines (uiop:read-file-lines file-path))
    (create-buffer (file-namestring file-path) file-path file-lines)))
