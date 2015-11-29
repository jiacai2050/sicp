(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda(p q) p)))

(define (cdr z)
  (z (lambda(p q) q)))

(cdr (cons 4 5))