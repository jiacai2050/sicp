
;递归算法
(define (triangle row col)
  (cond
    ((= col 1) 1)
    ((= row col) 1)
    (else 
      (+ (triangle (- row 1) (- col 1))
         (triangle (- row 1) col)))))
;迭代算法
(define (fact n)
  (define (fact-iter count product)
    (if (< n count) 
      product
      (fact-iter (+ 1 count) (* count product))))
  (if (= n 0) 
    1
    (fact-iter 1 1)))

(define (triangle2 row col)
  (/ (fact (- row 1))
     (fact (- col 1))
     (fact (- row col))))
