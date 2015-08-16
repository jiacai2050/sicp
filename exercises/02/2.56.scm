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
                      (make-exponentiation u (- n 1))
                      (deriv u var))))
    (else
      (error "Unknown expression type: DERIV" exp))))

(define (make-exponentiation u n)
  (cond
    ((= n 0) 1)
    ((= n 1) u)
    (else (** u n))))

(define (exponentiation? exp)
  (same-variable? ** (car exp)))

(define base cadr)
(define exponent caddr)