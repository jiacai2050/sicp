(load "3.70.scm")

(define (cube x)
  (* x x x))
(define (weight i j)
  (+ (cube i) (cube j)))

(define p (weighted-pairs integers integers weight))

(define (pair-weigth p)
  (weight (car p) (cdr p)))

(define (generate-ramanujan-number pairs)
  (let ((first (stream-car pairs))
        (second (stream-car (stream-cdr pairs))))
    (if (= (pair-weigth first) (pair-weigth second))
      (cons-stream (pair-weigth first)
        (generate-ramanujan-number (stream-cdr pairs)))
      (generate-ramanujan-number (stream-cdr pairs)))))

(define ramanujan-number (generate-ramanujan-number p))

(display-top10 ramanujan-number)
; 1729  4104  13832  20683  32832  39312  40033  46683  64232  65728