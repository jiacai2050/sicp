;变量就是符号，用基本的symbol?进行判断
(define (variable? x ) (symbol? x))
(define (same-variable? x y)
  (and (variable? x) (variable? y) (eq? x y)))

(define (make-sum a1 a2)
  (list '+ a1 a2))  
(define (make-product m1 m2)
  (list '* m1 m2))  
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))  
(define (augend s) (caddr s))
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))  
(define (multiplicand p) (caddr p))

;改进版
(define (=number? exp num)
  (and (number? exp) (= exp num)))
(define (make-sum a1 a2)
  (cond
    ((=number? a1 0) a2)
    ((=number? a2 0) a1)
    ((and (number? a1) (number? a2)) (+ a1 a2))
    (else (list '+ a1 a2))))
(define (make-product m1 m2)
  (cond
    ((or (=number? m1 0) (=number? m2 0)) 0)
    ((=number? m1 1) m2)
    ((=number? m2 1) m1)
    ((and (number? m1) (number? m2)) (* m1 m2))
    (else (list '* m1 m2))))


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
    (else
      (error "Unknown expression type: DERIV" exp))))

