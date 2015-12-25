(define (pow b n)
  (define (even? x) (= (remainder x 2) 0))
  (cond 
    ((= n 0) 1)
    ((even? n) (square (pow b (/ n 2))))
    (else 
      (* b (pow b (- n 1))))))

(define (cons x y)
  (*
    (pow 2 x)
    (pow 3 y)))
    
(define (iter res count divider)
  (if (= 0 (remainder res divider))
    (iter (/ res divider) (+ 1 count) divider)
    count))
    
(define (car z)
  (iter z 0 2))
(define (cdr z)
  (iter z 0 3))

(car (cons 5 4))
;5
(cdr (cons 5 4))
;4
