(load "lib/stream.scm")

(define (merge-weighted s t weight)
  (cond
    ((stream-null? s) t)
    ((stream-null? t) s)
    (else 
      (if (> (weight (car (stream-car s)) (cdr (stream-car s)))
             (weight (car (stream-car t)) (cdr (stream-car t))))
        (cons-stream (stream-car t) (merge-weighted s (stream-cdr t) weight))
        (cons-stream (stream-car s) (merge-weighted (stream-cdr s) t weight))))))


(define (weighted-pairs s t weight)

  (cons-stream 
    (cons (stream-car s) (stream-car t))
    (merge-weighted
      (stream-map (lambda (x) (cons (stream-car s) x))
                  (stream-cdr t))
      (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
      weight)))

; a)

(define p (weighted-pairs integers integers +))
(display-top10 p)
; (1 . 1)  (1 . 2)  (1 . 3)  (2 . 2)  (1 . 4)  (2 . 3)  (1 . 5)  (2 . 4)  (3 . 3)  (1 . 6)

(define p (weighted-pairs integers integers (lambda (i j) (+ (* 2 i) (* 3 j) (* 5 i j)))))
(display-top10 p)
; (1 . 1)  (1 . 2)  (1 . 3)  (2 . 2)  (1 . 4)  (1 . 5)  (2 . 3)  (1 . 6)  (2 . 4)  (1 . 7)