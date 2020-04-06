(defpackage trivial-prng
  (:use :cl)
  (:export
   #:take-n-random-values
   #:with-seed
   #:random-int-generator
   #:random-int))

(in-package :trivial-prng)


;;The variable storing all the current sessions' random-states
(defparameter *statehash*
  (make-hash-table :test #'equal))

(defun get-state (key &optional (hash *statehash*))
  "Returns a copy of the random state from a HASH of random-states with KEY"
  (let ((state (gethash key hash)))
    (if state
        (make-random-state state)
        (make-random-state (setf (gethash key hash) (make-random-state t))))))

(defmacro with-seed (seed &body body)
  "Overrides *random-state* with the random-state stored under SEED"
  `(let ((*random-state* (get-state ,seed)))
     ,@body))

(defun take-n-random-values (seed n range)
  "Takes N random numbers with RANGE using the random state stored under SEED"
  (with-seed seed
    (mapcar #'random (make-list n :initial-element range))))

(defun random-int-generator (seed range)
  "Returns a closure that generates a random number in RANGE with state stored under SEED"
  ;; Can't override the dynamic binding in a closure so we're
  ;; introducing a new lexical binding
  (let ((state (get-state seed)))
    #'(lambda() (random range state))))

(defun random-int (seed range)
  "Returns one random number in RANGE with random state stored under SEED."
  (with-seed seed
    (random range)))
