(defpackage :disirigi
  (:use #:cl
        #:alexandria))

(in-package #:disirigi)

(defmacro aŭ (&rest aroj)
  `(append ,@aroj))

(defun radikaligu (vorton)
  )

(defparameter +postfiksoj+
  '("a" "e" "i" "o"

    ;; Verbs
    "as" "is" "os" "us" "u"

    ;; Participles
    "inta" "onta" "anta"
    "ita" "ota" "ata"

    "intaj" "ontaj" "antaj"
    "itaj" "otaj" "ataj"

    ;; Gerund-likes
    "into" "onto" "anto"
    "ito" "oto" "ato"

    "intoj" "ontoj" "antoj"
    "itoj" "otoj" "atoj"

    ))
