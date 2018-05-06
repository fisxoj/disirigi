(defpackage :t/disirigi/normaligi
  (:use #:cl #:prove #:alexandria #:disirigi/normaligi))

(in-package #:t/disirigi/normaligi)

(defvar +cxiu-litero+ '(#\a #\b #\c #\ĉ #\d #\e #\f #\g #\ĝ #\h #\ĥ #\i #\j #\ĵ #\k #\l #\m #\n #\o #\p #\q #\r #\s #\ŝ #\t #\u #\ŭ #\v #\w #\x #\y #\z))

(defvar +akzentebla+ '(#\c #\j #\g #\s #\h #\u))

(defvar +akzentitaj+ '(#\ĉ #\ĝ #\ĥ #\ĵ #\ŝ #\ŭ))

(defvar +helpliteroj+ '(#\h #\x #\j))

(plan 7)

(subtest "akzentebla-p"
  (ok (every #'akzentebla-p +akzentebla+)
      "All accentable letters are recognized.")
  (ok (notany #'akzentebla-p (set-difference +akzentebla+ +cxiu-litero+))
      "No non-accentable letter is incorrecly marked accentable."))

(subtest "akzentita-p"
  (ok (every #'akzentita-p +akzentitaj+)
      "Every accented character is recognized as such.")
  (ok (notany #'akzentita-p (set-difference +akzentitaj+ +cxiu-litero+))
      "No unaccented character is misidentified."))

(subtest "helplitero-p"
  (ok (every #'helplitero-p +helpliteroj+)
      "All help-letters are identified.")
  (ok (notany #'helplitero-p (set-difference +helpliteroj+ +cxiu-litero+))
      "No other letters are mistaken for a help-letter."))

(subtest "akzentigu"
  (ok (every (lambda (e) (char= (cdr e) (akzentigu (car e)))) disrigi/normaligi::+cirkumfleksaj-literoj+)
      "All accentable letters are turned into their correct counterpart.")

  (let ((case-fns (alexandria:circular-list #'char-upcase #'char-downcase)))
    (ok (every (lambda (e) (let ((case-fn (pop case-fns))) (char= (funcall case-fn (cdr e)) (akzentigu (funcall case-fn (car e)) t)))) disrigi/normaligi::+cirkumfleksaj-literoj+)
        "All accentable letters are turned into their correct counterpart, preserving case."))

  (ok (every (lambda (c) (char= c (akzentigu c))) (set-difference +akzentebla+ +cxiu-litero+))
      "All non-accentable letters are returned as-is."))


(subtest "akzentigu"
  (ok (every (lambda (e) (char= (car e) (malakzentigu (cdr e)))) disrigi/normaligi::+cirkumfleksaj-literoj+)
      "All accented letters are turned into their correct counterpart.")

  (let ((case-fns (alexandria:circular-list #'char-upcase #'char-downcase)))
    (ok (every (lambda (e) (let ((case-fn (pop case-fns))) (char= (funcall case-fn (car e)) (malakzentigu (funcall case-fn (cdr e)) t)))) disrigi/normaligi::+cirkumfleksaj-literoj+)
        "All accented letters are turned into their correct counterpart, preserving case."))

  (ok (every (lambda (c) (char= c (malakzentigu c))) (set-difference +akzentebla+ +cxiu-litero+))
      "All non-accentable letters are returned as-is."))

(subtest "normaligu"
  (is (normaligu "La cxevalo mangxas la novajxon en Hxinio.") "La ĉevalo manĝas la novaĵon en Ĥinio."))

(subtest "malnormaliu"
  (is (malnormaligu "La ĉevalo manĝas la novaĵon en Ĥinio.") "La cxevalo mangxas la novajxon en Hxinio."))

(finalize)
