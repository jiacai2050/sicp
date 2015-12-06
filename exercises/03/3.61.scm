(load "3.60.scm")

(define (reciprocal-series s)
  (cons-stream 1
    (mul-series (scale-stream (stream-cdr s) -1)
                (reciprocal-series s))))

(define foo (reciprocal-series exp-series))
(define bar (mul-series exp-series foo))

(for-each (lambda (x) (display-blank (stream-ref foo x))) (range 0 10))
(newline)
;1 -1 1/2 -1/6 1/24 -1/120 1/720 -1/5040 1/40320 -1/362880
(for-each (lambda (x) (display-blank (stream-ref bar x))) (range 0 10))
(newline)
; 1 0 0 0 0 0 0 0 0 0