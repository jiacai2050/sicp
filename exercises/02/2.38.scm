(load "lib/op.scm")

(define (fold-right op initial sequence)
  (accumulate op initial sequence))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))

(fold-left / 1 (list 1 2 3))
;Value: 1/6
(fold-right / 1 (list 1 2 3))
;Value: 3/2
(fold-left list nil (list 1 2 3))
;Value: (((() 1) 2) 3)
(fold-right list nil (list 1 2 3))
;Value: (1 (2 (3 ())))