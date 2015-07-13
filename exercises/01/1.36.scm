(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)

(define (average x y) (/ (+ x y) 2))

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)
;67次才得到最终的结果
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 2.0)
;42次才得到最终的结果