(defsystem "cled"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main") (:file "buffers"))))
  :description ""
  :in-order-to ((test-op (test-op "cled/tests"))))

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
