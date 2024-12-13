(defsystem "cled"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 ;; (:file "buffers")
		 (:module "buffers"
		  :components ((:file "get") (:file "create") (:file "undo") (:file "update") (:file "delete"))
		 ))
		))
  :description ""
  :in-order-to ((test-op (test-op "cled/tests"))))

;; TESTING -- not yet
(defsystem "cled/tests"
  :author ""
  :license ""
  :depends-on ("cled"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for cled"
  :perform (test-op (op c) (symbol-call :rove :run c)))
