#!/usr/bin/env -S sbcl --script

(require :uiop )

(load "~/.sbclrc")
(ql:quickload "cled" :silent t)
(let ((cmd ""))
  (loop while (not (string-equal cmd "exit")) do
	      (progn
		(format *query-io* "~a: " "cmd")
		(finish-output *query-io*)
		(setq cmd (read-line *query-io*))
		(if (string= cmd "exit")
		    (princ (concatenate 'string "goodbye " (uiop:getenv "USER") "!" '(#\Newline)))
		    (princ (concatenate 'string '(#\Newline) (format *query-io* "~a" (eval (read-from-string cmd))))))
		)))
