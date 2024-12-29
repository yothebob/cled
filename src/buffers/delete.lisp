(in-package :cled)

(defun delete-buffer (select-fun &key buffer-index)
  ;; TODO: impliment buffer-index so if there are multiple, user can select one buffer-index
  (setq *BUFFERS* (remove-if select-fun *BUFFERS*)))
