(in-package :cled)

(defun get-buffer-line (buffer line)
  (let ((buffer buffer) (line line)
	(line-contents nil) (contents (getf buffer :contents)))
    (if (not contents) (return-from get-buffer-line nil))
    (if (equal (nth line contents) nil) (return-from get-buffer-line nil))
    (nth line contents)))

(defun get-buffer (select-fun &key buffer-index)
  ;; TODO: Buffer names should be unique or increment the name
  ;; TODO: impliment buffer-index so if there are multiple, user can select one buffer-index
  (car (remove-if-not select-fun *BUFFERS*)))

(defun get-buffers (select-fun &key buffer-index)
  ;; TODO: Buffer names should be unique or increment the name
  ;; TODO: impliment buffer-index so if there are multiple, user can select one buffer-index
  (remove-if-not select-fun *BUFFERS*))


