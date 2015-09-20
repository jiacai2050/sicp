; 实现稠密多项式的表示
(define (adjoin-term term term-list)
  (if (emtpy-termlist? term-list)
    term
    (list term term-list)))

(define the-empty-termlist '())

(define (first-term term-list) (car term-list))
(define (rest-term term-list) (cdr term-list))

(define (emtpy-termlist? term-list)
  (null? term-list))

(define (make-term order coeff)
  (define (iter order)
    (if (= 0 order)
      '(0)
      (cons 0 (iter (- order 1)))))
  (cons coeff (iter (- order 1))))

(make-term 4 5)
;Value: (5 0 0 0 0)