(in-package :cled)

(defvar *BUFFERS* '())
(defvar *CURRENT-BUFFER* nil)

(defun check-buffer-name-collision (name)
  "Helper function to take a NAME and see what the next buffer name would be."
  (let ((buffer-quantity 0))
    (setq buffer-quantity (list-length (get-buffers (where :name name))))
    (if (> buffer-quantity 0)
	(setq name (format nil "~a<~a>" name (+ buffer-quantity 1))))
    name))

(defun create-buffer (name path contents)
  "Create a buffer from NAME PATH and CONTENTS."
  ;; check if path exists?
  (let ((bname (check-buffer-name-collision name)))
  (push (list :name bname :path path :contents contents) *BUFFERS*)))

(defun create-file (file-path)
  (print "TODO: impliment a function for creating a new file and creating a buffer for it.")
  )

(defun load-file (&key (file-path nil)) ;; TODO: does this work with a new file?
  "Read IO to load file and create buffer, or create buffer from FILE-PATH."
  (let ((fp file-path) file-lines)
    (if (equal file-path nil) (setq fp (uiop:native-namestring (read-line))))
    (if (probe-file fp)
	(setq file-lines (uiop:read-file-lines fp))
	(setq file-lines '("")))
    (create-buffer (file-namestring fp) fp file-lines)))


;;TODO: Create file/directory
