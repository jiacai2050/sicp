(define (product a term b next)
  (if (> a b)
    1
    (* (term a)
       (product (next a) term b next))))

(define (identity x) x)
(define (inc x) (+ x 1))

(define (factorial n)
  (product 1 identity n inc))
;(a)
(factorial 5)
;Value: 120

(define (pi a b)
  (define (pi-term n) 
    (if (even? n) 
      (/ (+ n 2) (+ n 1)) 
      (/ (+ n 1) (+ n 2))))
  (* 4.0
     (product a pi-term b inc)))

(pi 1 100)
;Value: 3.1570301764551676

;(b)
(define (product2 a term b next)
  (define (iter a result)
    (if (> a b)
      1
      (* (term a)
         (iter (next a) result))))
  (iter a 1))