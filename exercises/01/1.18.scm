(define (mul-iter a b product)
  (cond
    ((= b 0) product)
    ((even? b) (mul-iter (* 2 a) (/ b 2) product))
    (else
      (mul-iter a (- b 1) (+ a product)))))

(define (mul a b)
  (mul-iter a b 0))

(mul 5 100)
