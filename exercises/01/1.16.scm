(define (fast-expt-iter p n a)
    (cond
        ((= n 0) a)
        ((even? n) (fast-expt-iter (square p) (/ n 2) a))
        (else (fast-expt-iter p (- n 1) (* a p)))))
(define (fast-expt2 p n)
    (fast-expt-iter p n 1))

(fast-expt2 2 10)
;Value: 1024