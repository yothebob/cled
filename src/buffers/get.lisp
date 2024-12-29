(in-package :cled)

;; I dont think this function works...
(defun get-buffer-line (buffer line)
  (let ((buffer buffer) (line line)
	(line-contents nil) (contents (getf buffer :contents)))
    (if (not contents) (return-from get-buffer-line nil))
    (if (equal (nth line contents) nil) (return-from get-buffer-line nil))
    (nth line contents)))

(defun get-buffer-contents (buffer)
  "Return contents of a buffer."
  (getf buffer :contents))

(defun get-buffer (select-fun &key buffer-index)
  (let ((bi 0) (buffer-list (remove-if-not select-fun *BUFFERS*)))
    (if buffer-index (setq bi buffer-index))
    (nth bi buffer-list)))

(defun get-buffers (select-fun)
  (remove-if-not select-fun *BUFFERS*))


