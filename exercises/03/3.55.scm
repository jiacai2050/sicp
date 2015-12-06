(load "lib/stream.scm")

(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (stream-cdr s)
                            (partial-sums s))))

(define z (partial-sums integers))

(stream-ref z 0)
;Value: 1
(stream-ref z 1)
;Value: 3
(stream-ref z 2)
;Value: 6
(stream-ref z 3)
;Value: 10
(stream-ref z 4)
;Value: 15