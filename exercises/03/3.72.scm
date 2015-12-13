(load "3.70.scm")

(define (weight i j)
  (+ (square i) (square j)))

(define p (weighted-pairs integers integers weight))

(define (pair-weigth p)
  (weight (car p) (cdr p)))

(define (generate-num-seq pairs)
  (let ((first (stream-car pairs))
        (second (stream-car (stream-cdr pairs)))
        (third (stream-car (stream-cdr (stream-cdr pairs)))))
    (if (= (pair-weigth first) (pair-weigth second) (pair-weigth third))
      (begin
        (display-blank first)
        (display-blank second)
        (display-blank third)
        (display-blank (pair-weigth first))
        (newline)
        (cons-stream (pair-weigth first)
          (generate-num-seq (stream-cdr pairs))))
      (generate-num-seq (stream-cdr pairs)))))

(define num-seq (generate-num-seq p))

(stream-ref num-seq 10)
; (1 . 18)  (6 . 17)  (10 . 15)  325
; (5 . 20)  (8 . 19)  (13 . 16)  425
; (5 . 25)  (11 . 23)  (17 . 19)  650
; (7 . 26)  (10 . 25)  (14 . 23)  725
; (2 . 29)  (13 . 26)  (19 . 22)  845
; (3 . 29)  (11 . 27)  (15 . 25)  850
; (5 . 30)  (14 . 27)  (21 . 22)  925
; (1 . 32)  (8 . 31)  (20 . 25)  1025
; (4 . 33)  (9 . 32)  (12 . 31)  1105
; (9 . 32)  (12 . 31)  (23 . 24)  1105
; (5 . 35)  (17 . 31)  (25 . 25)  1250
;Value: 1250