(define (nontrivial-square-root? m)
  (if (= m 1)
    0
    m))

(define (expmod base exp m)
  (cond 
    ((= exp 0) 1)
    ((even? exp)
      (nontrivial-square-root? 
        (remainder (square (expmod base (/ exp 2) m)) m)))
    (else
      (remainder (* base (expmod base (- exp 1) m))
                 m))))

(define (fermat-test a n)
  (= (expmod a (- n 1) n) a))

(define (fast-prime? n)
  (define (fast-prime-iter acc)
    (cond 
      ((= acc n) true)
      ((fermat-test acc n) (fast-prime-iter (+ acc 1)))
      (else false)))
  (fast-prime-iter 1))
 
(fast-prime? 561)
;Value: #f
(fast-prime? 1105)
;Value: #f