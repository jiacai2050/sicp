(load "2.46.scm")

(define (make-segment s e)
  (cons s e))

(define (start-segment s)
  (car s))
(define (end-segment s)
  (cdr s))