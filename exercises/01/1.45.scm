(load "lib/fixed_point.scm")
(load "./1.43.scm") ; load repeated

(define (average-damp f)
  (lambda (x)
    (/ (+ x (f x)) 2)))

;http://www.billthelizard.com/2010/08/sicp-145-computing-nth-roots.html
;我这里直接借用这个网址的方法，它给出了n与damp的次数关系
;maximum n: 3, 7, 15
;average damps: 1, 2, 3
;在根据它总结的公式，可以得出下面的过程：

(define (log2 x)
  (/ (log x) (log 2)))

(define (nth-root x n)
  (fixed-point
      ((repeated average-damp (floor (log2 n)))
          (lambda (y) (/ x (expt y (- n 1)))))
      1.0))