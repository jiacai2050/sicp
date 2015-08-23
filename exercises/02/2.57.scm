(load "lib/deriv.scm")

(define (make-sum . args)
  (define (iter res l)
    (if (null? l)
      res
      (let ((first (car l)))
        (if (=number? first 0)
          (iter res (cdr l))
          (iter (append res (list (car l)))
                (cdr l))))))
  (iter '(+) args))

(define (addend exp)
  (cadr exp))

(define (augend exp)
  (define (iter result l)
    (if (null? l)
      result
      (iter (append result (list (car l)))
            (cdr l))))
  (if (null? (cdddr exp))
    (caddr exp)
    (let ((rest (cddr exp)))
      (iter '(+) rest))))

(define (make-product . args)
  (define (iter res l)
    (if (null? l)
      res
      (iter (append res (list (car l)))
            (cdr l))))
  (iter '(*) args))

(define (multiplier exp)
  (cadr exp))

(define (multiplicant exp)
  (define (iter result l)
    (if (null? l)
      result
      (iter (append result (list (car l)))
            (cdr l))))
  (if (null? (cdddr exp))
    (caddr exp)
    (let ((rest (cddr exp)))
      (iter '(*) rest))))


(addend '(+ x 4 2 2))
(augend '(+ x 4 2 2))
(make-sum 1 2 3)
(deriv '(+ x (* y x) x 12) 'x)
;Value: (+ 1 (+ (+ (* y 1) (* x 0)) (+ 1)))