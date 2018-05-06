(asdf:defsystem "disirigi"
  :author "Matt Novenstern <fisxoj@gmail.com>"
  :license "LLGPLv3+"
  :pathname #P"src/"
  :depends-on ("alexandria")
  :components ((:file "normaligi")
               (:file "disirigi"))
  :in-order-to ((test-op (test-op disirigi-test))))
