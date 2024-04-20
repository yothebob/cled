(defpackage cled/tests/main
  (:use :cl
        :cled
        :rove))
(in-package :cled/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :cled)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
