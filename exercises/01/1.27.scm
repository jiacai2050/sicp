(define (expmod base exp m)
  (cond 
    ((= exp 0) 1)
    ((even? exp)
      (remainder (square (expmod base (/ exp 2) m)) 
                 m))
    (else
      (remainder (* base (expmod base (- exp 1) m))
                 m))))

(define (fermat-test a n)
  (= (expmod a n n) a))

(define (fast-prime? n)
  (define (fast-prime-iter acc)
    (cond 
      ((= acc n) true)
      ((fermat-test acc n) (fast-prime-iter (+ acc 1)))
      (else false)))
  (fast-prime-iter 1))

(fast-prime? 19999)
;Value: #f