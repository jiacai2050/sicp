(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond 
    ((> (square test-divisor) n) n)
    ((= (remainder n test-divisor) 0) test-divisor)
    (else (find-divisor n (+ test-divisor 1)))))

(smallest-divisor 199)
;Value: 199
(smallest-divisor 1999)
;Value: 1999
(smallest-divisor 19999)
;Value: 7