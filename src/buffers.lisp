(in-package :cled)

(defvar *BUFFERS* '())
(defvar *CURRENT-BUFFER* nil)

(defun create-buffer (name path contents)
  (let ((name name) (buffer-quantity 0))
    (setq buffer-quantity (list-length (get-buffers (where :name name))))
    (if (> buffer-quantity 0)
	(setq name (format nil "~a<~a>" name (+ buffer-quantity 1))))
  (push (list :name name :path path :contents contents) *BUFFERS*)))

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

(defun get-buffer (select-fun &key buffer-index)
  ;; TODO: Buffer names should be unique or increment the name
  ;; TODO: impliment buffer-index so if there are multiple, user can select one buffer-index
  (car (remove-if-not select-fun *BUFFERS*)))

(defun get-buffers (select-fun &key buffer-index)
  ;; TODO: Buffer names should be unique or increment the name
  ;; TODO: impliment buffer-index so if there are multiple, user can select one buffer-index
  (remove-if-not select-fun *BUFFERS*))
