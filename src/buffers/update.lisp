(in-package :cled)

(defun buffer-update (buffer &key name path contents) ;; maybe pass selector-fun instead of buffer ;; TODO: this function could be cleaned up alot
  (if name (setf (getf buffer :name) name))
  (if path (setf (getf buffer :path) path))
  (if contents (setf (getf buffer :contents) contents)))

(defun add-buffer-line--end (buffer &key contents write)
  (let ((buffer buffer) (new-contents contents) (old-contents (getf buffer :contents)))
    (if (not contents) (setq contents (read-line)))
    (push new-contents
	  (cdr (last (getf buffer :contents))))
    (if write (cled::write-contents buffer))))

;; (defun write-buffer-to-file
;; "Take an existing buffer (or current buffer?) and write its contents to a new file. THEN, update buffer path & name." )
;; (defun write-buffer-to-file (buffer filename)
;;   "Write the contents of BUFFER to FILENAME."
;;   (let ((content (gethash 'content (gethash buffer *buffers*))))
;;     (with-open-file (stream filename
;;                               :direction :output
;;                               :if-exists :supersede)
;;       (write-string content stream))))


(defun update-buffer-line (buffer &key line contents write)
  (let ((buffer buffer) (contents contents))
    (if (not contents) (setq contents (read-line)))
    (setf (nth line (getf buffer :contents)) contents)
    (if write (cled::write-contents buffer))))



