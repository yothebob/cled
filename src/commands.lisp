#!/usr/bin/env -S sbcl --script

(require :uiop)

;; We want quicklisp, which is loaded from our initfile,
;; after a classical installation.
;; However the --script flag doesn't load our init file:
;; it implies --no-sysinit --no-userinit --disable-debugger --end-toplevel-options
;; So, please load it:
;;(member "-h" (uiop:command-line-arguments) :test #'string-equal)
(print (uiop:command-line-arguments))
;; (load "~/.sbclrc")

;; ;; Load a quicklisp dependency silently.
;; (ql:quickload "str" :silent t)

;; (princ (str:concat "hello " (uiop:getenv "USER") "!"))

;; command options:
;; - [ ] {file/dir}
;; - [ ] Client (default)
;; - [ ] Server
;; - [ ] offline (default)
;; - [ ] online (default connection)
;; - [ ] online (custom connection)
;; - [ ] remote command "..."


