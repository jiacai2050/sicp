(define (make-accumulator acc)
  (lambda (x)
    (set! acc (+ acc x))
    acc))

(define A (make-accumulator 5))

(A 10)
;Value: 15
(A 10)
;Value: 25