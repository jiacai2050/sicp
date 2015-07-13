(define (gcd x y)
  (let ((tmp (remainder x y)))
    (if (= 0 tmp)
      y
      (gcd y tmp))))

(define (make-rat x y)
  (let ((g (gcd x y)))
    (if (< (/ x y) 0)
      (cons (/ (- x) g) (/ y g))
      (cons (/ x g) (/ y g)))))