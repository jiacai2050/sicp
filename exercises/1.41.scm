(define (double f)
  (lambda (x)
    (f (f x))))

(define (inc x) (+ 1 x))

((double inc) 1)
;3
(((double double) inc) 3)
;7
(((double (double double)) inc) 5)
;21

(double double)
;------->
(lambda (x)
  (double (double x)))
;++++++++++++++++++++++++++++++++++++++++++++++++++++
(double (double double))
;------->
(lambda (x)
  ((lambda (x) (double (double x)))
    ((lambda (x) (double (double x))) x)))
;++++++++++++++++++++++++++++++++++++++++++++++++++++
((double (double double)) inc)
;------->
(double double (double (double inc))