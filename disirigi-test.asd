(defsystem "disirigi-test"
  :author "Matt Novenstern"
  :pathname #P"t/"
  :depends-on ("disirigi"
               "prove")
  :components ((:test-file "normaligi"))
  :defsystem-depends-on ("prove-asdf")
  :perform (test-op (op c) (symbol-call :prove-asdf '#:run-test-system c)))
