(load "lib/list.scm")
(load "2.28.scm")

(define (count-leaves t)
  (accumulate (lambda (x y) (+ x y))
              0
              (map (lambda(x) 1) (fringe t))))

(count-leaves (list 1 (list 2 (list 3 4) 5)))
;Value: 5