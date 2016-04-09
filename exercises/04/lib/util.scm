(define (tagged-list? exp tag)
  (if (pair? exp)
    (eq? (car exp) tag)
    false))

(define (last-exp? seq) (null? (cdr seq)))

(define (first-exp exp) (car exp))

(define (rest-exps exp) (cdr exp))
