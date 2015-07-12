
(define dx 0.00001)

(define (smooth f)
  (lambda (x)
    (/ 
      (+ (f x)
         (f (- x dx))
         (f (+ x dx)))
      3)))

(define (n-smooth f n)
  (repeated smooth n))