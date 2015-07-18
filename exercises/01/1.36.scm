(load "lib/fixed_point.scm")

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)

(define (average x y) (/ (+ x y) 2))

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)
;67次才得到最终的结果
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 2.0)
;42次才得到最终的结果