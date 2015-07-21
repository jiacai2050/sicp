(load "2.17_2.18.scm")

(define (deep-reverse items)
  (cond
    ((null? items) nil)
    ((not (pair? items)) items)
    (else 
      (append (deep-reverse (cdr items))
              (list (deep-reverse (car items)))))))

(define x (list (list 1 2) (list 3 4)))
;Value: ((1 2) (3 4))
(reverse x)
;Value: ((3 4) (1 2))
(deep-reverse x)
;Value: ((4 3) (2 1))