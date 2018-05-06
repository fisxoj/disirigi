(defpackage :disirigi/normaligi
  (:use #:cl
        #:alexandria)
  (:export #:akzentebla-p
           #:akzentita-p
           #:helplitero-p
           #:akzentigu
           #:malakzentigu
           #:normaligu
           #:malnormaligu
           ))

(in-package #:disirigi/normaligi)

(defconstant +cirkumfleksaj-literoj+
  '((#\c . #\ĉ)
    (#\s . #\ŝ)
    (#\g . #\ĝ)
    (#\j . #\ĵ)
    (#\h . #\ĥ)
    (#\u . #\ŭ))
  "Literoj kiuj akceptas cirkumflekson.")

(defconstant +helpliteroj+
  '(#\h #\x #\j)
  "Literoj kiuj signifas ke la malproksima litero estus akzentita.")

(defun akzentebla-p (c)
  (declare (type character c))
  (member c +cirkumfleksaj-literoj+ :test #'char-equal :key #'car))

(defun akzentita-p (c)
  (declare (type character c))
  (member c +cirkumfleksaj-literoj+ :test #'char-equal :key #'cdr))

(defun helplitero-p (c)
  (declare (type character c))
  (member c +helpliteroj+ :test #'char-equal))

(defun akzentigu (c &optional preserve-case)
  (declare (type character c))
  (if-let ((akzentito (or (cdr (assoc c +cirkumfleksaj-literoj+ :test #'char-equal)) c)))
    (if preserve-case
        (if (upper-case-p c)
            (char-upcase akzentito)
            (char-downcase akzentito))
        akzentito)))

(defun malakzentigu (c &optional preserve-case)
  (if-let ((akzentito (or (car (rassoc c +cirkumfleksaj-literoj+ :test #'char-equal)) c)))
    (if preserve-case
        (if (upper-case-p c)
            (char-upcase akzentito)
            (char-downcase akzentito))
        akzentito)))

(defun normaligu (string)
  (with-output-to-string (s)
    (loop with akzenteblo
          for c across string
          do (progn (if (and (null akzenteblo) (akzentebla-p c))
                        (setf akzenteblo c)
                        (if akzenteblo
                            (progn (if (helplitero-p c)
                                       (princ (akzentigu akzenteblo t) s)
                                       (progn (princ akzenteblo s)
                                              (princ c s)))
                                   (setf akzenteblo nil))
                            (princ c s)))))))

(defun malnormaligu (string &optional (helplitero #\x))
  (with-output-to-string (s)
    (loop for c across string
          if (akzentita-p c)
            do (princ (malakzentigu c t) s)
            and do (princ helplitero s)
          else
            do (princ c s))))
