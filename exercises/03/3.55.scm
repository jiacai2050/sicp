(load "lib/stream.scm")

; 我这里给出两种解法，本质上是等价的，只不过第二种比第一种效率要高些。高的具体原因可参考习题3.64

(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (stream-cdr s)
                            (partial-sums s))))

(define n (partial-sums integers))

(display-top10 n)
; 1 3 6 10 15 21 28 36 45 55

(define (partial-sums2 s)
  (define p
    (cons-stream (stream-car s)
                 (stream-map + p (stream-cdr s))))
  p)

(define m (partial-sums2 integers))

(display-top10 m)
; 1 3 6 10 15 21 28 36 45 55