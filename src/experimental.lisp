(defun write-buffer-to-editing-region (buffer region-start region-end)
  "Write the contents of BUFFER to the editing region.
REGION-START and REGION-END specify the region."
  (let ((content (gethash 'content (gethash buffer *buffers*))))
    (setf (gethash 'region-start *current-buffer*)
          region-start)
    (setf (gethash 'region-end *current-buffer*)
          region-end)))

(defun read-editing-region-from-buffer ()
  "Read the editing region from BUFFER.
Returns a string containing the text in the region."
  (let ((region-start (gethash 'region-start *current-buffer*))
        (region-end (gethash 'region-end *current-buffer*)))
    (subseq
     (gethash 'content (gethash *current-buffer* *buffers*))
     region-start
     (+ region-end (- region-end region-start)))))

(defparameter *current-buffer* nil)

(defparameter *buffers* (make-hash-table :test #'equal))

(defun insert-at-point! (buf pos text)
  "Insert TEXT at position POS in BUFFER BUF."
  (let ((contents (elt buf 1)))
    (setf contents (concatenate 'string (subseq contents 0 pos) text (subseq contents pos)))
    (setf (elt buf 1) contents)))

(defun delete-region! (buf start end)
  "Delete text between positions START and END in BUFFER BUF."
  (let ((contents (elt buf 1)))
    (setf contents (concatenate 'string (subseq contents 0 start) (subseq contents (+ start (abs (- end start))))))))

(defun undo-last-edit! (buf)
  "Undo the last edit in BUFFER BUF."
  (let ((history (elt buf 2)))
    (setf contents (pop history))
    (setf (elt buf 1) contents)))

(defun redo-last-undo! (buf)
  "Redo the last UNDO in BUFFER BUF."
  (let ((history (elt buf 2)))
    (setf contents (push (car history) history))
    (setf (elt buf 1) contents)))
