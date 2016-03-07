(define (let? exp)
  (tagged-list? exp 'let))

(define (named-let? exp)
  (and (let? exp)
       (eq? 4 (length exp))))

(define (let-variables exp)
  (map car (cadr exp)))

(define (let-values exp)
  (map cadr (cadr exp)))

(define (let-body exp)
  (cddr exp))

(define (named-let-var exp)
  (cadr exp))
(define (named-let-bindings exp)
  (caddr exp))
(define (named-let-variables exp)
  (map car (named-let-bindings exp)))
(define (named-let-values exp)
  (map cadr (named-let-bindings exp)))
(define (named-let-body exp)
  (cdddr exp))


(define (let->combination exp)
  (cond
    ((named-let? exp)
      (list 'define (named-let-var exp)
                    (make-lambda (named-let-variables exp)
                                 (named-let-body exp)))
      ((named-let-var exp) named-let-values))
    (else
      ((make-lambda (let-variables exp)
                    (let-body exp))
        (let-values exp)))))
