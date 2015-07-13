(define (close-enough? v1 v2) 
   (define tolerance 1.e-6) 
   (< (/ (abs (- v1 v2)) v2)  tolerance)) 

(define (iterative-improve good-enough? improve)
  (lambda (x)
    (let ((xx (improve x)))
      (if (good-enough? x xx)
        x
        ((iterative-improve good-enough? improve) (improve x))))))

(define (sqrt y)
  (define (average m n) (/ (+ m n) 2))
  ((iterative-improve 
    close-enough?
    (lambda (x)
      (average x (/ y x))))
    1.0))

(sqrt 9)