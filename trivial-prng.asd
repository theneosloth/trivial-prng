(defsystem "trivial-prng"
  :version "0.1.0"
  :author "Stefan Kuznetsov"
  :license "LLGPL"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "A very thin wrapper for rebinding *random-state*."
  :in-order-to ((test-op (test-op "trivial-prng/tests"))))

(defsystem "trivial-prng/tests"
  :author "Stefan Kuznetsov"
  :license "LLGPL"
  :depends-on ("trivial-prng"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for trivial-prng"
  :perform (test-op (op c) (symbol-call :trivial-prng/tests/main :do-tests)))
