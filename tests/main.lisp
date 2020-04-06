(defpackage trivial-prng/tests/main
  (:use :cl
   :trivial-prng
        :fiveam)
  (:export
   #:do-tests))
(in-package :trivial-prng/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :trivial-prng)' in your Lisp.


(def-suite all-tests
  :description "Suite of all the tests.")

(in-suite all-tests)

(defun do-tests ()
  (run! 'all-tests))

(test int-generator-test
  (let
      ((generator-1 (trivial-prng:random-int-generator :seed 10))
       (generator-2 (trivial-prng:random-int-generator :seed 10)))
    (is (= (funcall generator-1) (funcall generator-2)))))


(test n-random-values-test
  (let
      ((n-first (trivial-prng:take-n-random-values :seed1 10 10))
       (n-second (trivial-prng:take-n-random-values :seed1 10 10)))

    (is (equal n-first n-second))))


(test with-random-test
  (let ((rand1 nil)
        (rand2 nil))
    (with-seed :seed2
      (setf rand1 (random 10)))
    (with-seed :seed2
      (setf rand2 (random 10)))
    (is (equal rand1 rand2))))

(test random-int-test
  (is (equal (trivial-prng:random-int :seed3 100) (trivial-prng:random-int :seed3 100))))
