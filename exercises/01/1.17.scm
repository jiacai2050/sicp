
(define (mul a b)
  (cond
    ((= b 1) a)
    ((even? b) (mul (* 2 a) (/ b 2)))
    (else
      (+ a
         (mul a (- b 1))))))

(mul 5 7)
