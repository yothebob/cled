(in-package :cled)

(defun buffer-update (buffer &key name path contents) ;; maybe pass selector-fun instead of buffer ;; TODO: this function could be cleaned up alot
  ;; TODO: if the buffer has a file, it needs to update all buffers pointing at same file
  (if name (setf (getf buffer :name) name))
  (if path (setf (getf buffer :path) path))
  (if contents (setf (getf buffer :contents) contents)))

(defun add-buffer-line--end (buffer &key contents write)
  ;; TODO: if the buffer has a file, it needs to update all buffers pointing at same file
  (let ((buffer buffer) (new-contents contents) (old-contents (getf buffer :contents)))
    (if (not contents) (setq contents (read-line)))
    (push new-contents
	  (cdr (last (getf buffer :contents))))
    (if write (cled::write-contents buffer))))

(defun write-buffer-to-file (buffer filepath)
  "Write the contents of BUFFER to FILEPATH, updating existing buffers."
  
  (let ((content (getf buffer :contents))
	(filename (cled::check-buffer-name-collision (file-namestring filepath))))
    (with-open-file (stream filepath
                              :direction :output
                              :if-exists :supersede)
		    (write-string content stream)))
  (cled::buffer-update buffer :name filename :path filepath))


(defun update-buffer-line (buffer &key line contents write)
  ;; TODO: if the buffer has a file, it needs to update all buffers pointing at same file
  (let ((buffer buffer) (contents contents))
    (if (not contents) (setq contents (read-line)))
    (setf (nth line (getf buffer :contents)) contents)
    (if write (cled::write-contents buffer))))



