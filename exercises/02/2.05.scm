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

(define (car z)
  (define (iter res count)
    (if (= 0 (remainder res 2))
      (iter (/ res 2) (+ 1 count))
      count))
  (iter z 0))
(define (cdr z)
  (define (iter res count)
    (if (= 0 (remainder res 3))
      (iter (/ res 3) (+ 1 count))
      count))
  (iter z 0))

(car (cons 5 4))
;5
(cdr (cons 5 4))
;4