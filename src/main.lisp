(defpackage trivial-prng
  (:use :cl)
  (:export
   #:take-n-random-values
   #:with-seed
   #:random-int-generator))

(in-package :trivial-prng)

(defparameter *statehash* (make-hash-table))

(defun get-state (key &optional (hash *statehash*))
  (let ((state (gethash key hash)))
    (if state
        (make-random-state state)
        (make-random-state (setf (gethash key hash) (make-random-state t))))))

(defmacro with-seed (seed &body body)
  `(let ((*random-state* (get-state ,seed)))
     ,@body))

(defun take-n-random-values (seed n range)
  (with-seed seed
    (mapcar #'random (make-list n :initial-element range))))

(defun random-int-generator (seed range)
  ;; Can't override the dynamic binding in a closure so we're
  ;; introducing a new lexical binding
  (let ((state (get-state seed)))
    #'(lambda() (random range state))))
