(load "lib/deriv.scm")
(define (deriv exp var)
  (cond
    ((number? exp) 0)
    ((variable? exp)
      (if (same-variable? exp var) 1 0))
    ((sum? exp)
      (make-sum (deriv (addend exp) var)
                (deriv (augend exp) var)))
    ((product? exp)
      (make-sum
        (make-product (multiplier exp)
                      (deriv (multiplicand exp) var))
        (make-product (multiplicand exp)
                      (deriv (multiplier exp) var))))
    ((exponentiation? exp)
      (let ((u (base exp))
            (n (exponent exp)))
        (make-product n
                      (make-product
                        (make-exponentiation u (- n 1))
                        (deriv u var)))))
    (else
      (error "Unknown expression type: DERIV" exp))))

(define (make-exponentiation u n)
  (cond
    ((=number? n 0) 1)
    ((=number? n 1) u)
    (else '(** u n))))

(define (exponentiation? exp)
  (same-variable? '** (car exp)))

(define base cadr)
(define exponent caddr)

(deriv '(* (* x y) (+ x 3)) 'x)
;Value: (+ (* x y) (* (+ x 3) y))
(deriv '(** x 2) 'x)
;Value: (* 2 x)
(deriv '(+ x (** x 2)) 'x)
;Value: (+ 1 (* 2 x))