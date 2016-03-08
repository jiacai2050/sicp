(load "4.6.scm")

(define (let*? exp)
  (tagged-list exp 'let*))

(define (expand-clauses bindings body)
  (if (null? bindings)
    body
    (make-let (list (car bindings))
              (expand-clauses (cdr bindings) body))))

(define (let*->nested-lets exp)
  (expand-clauses (let-bindings exp) (let-body exp)))
