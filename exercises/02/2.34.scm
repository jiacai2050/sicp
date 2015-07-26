(load "lib/op.scm")

(define (horner-eval x coefficitent-sequences)
  (accumulate (lambda (this-coeff higher-terms) (+ this-coeff (* x higher-terms)))
              0
              coefficitent-sequences))

(horner-eval 2 (list 1 3 0 5 0 1))
;Value: 79