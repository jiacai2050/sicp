(load "lib/stream.scm")

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (interleave (stream-map (lambda (x) (list x (stream-car t)))
                              (stream-cdr s))
        (pairs (stream-cdr s) (stream-cdr t))))))

(define p (pairs integers integers))
(display-top10 p)
; (1 1)  (1 2)  (2 1)  (1 3)  (2 2)  (1 4)  (3 1)  (1 5)  (2 3)  (1 6)