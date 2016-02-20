
(define (eval-and exp env)
  (if (null? exp)
    true
    (and (eval (car exp) env)
         (eval-and (cdr exp) env))))

(define (eval-or exp env)
  (if (null? exp)
    true
    (or (eval (car exp) env)
        (eval-or (cdr exp) env))))

; 上面定义好 eval-and、eval-or 后，可以修改 eval 了，加在 quoted? 与 cond? 之间的任意位置都可以。


; 派生表达式的实现方式

(define (eval-and exp env)
  (if (null? exp)
    true
    (make-if (car exp) (cdr exp) false) env))
         

(define (eval-or exp env)
  (if (null? exp)
    true
    (make-if (car exp) true (cdr exp)) env))
    
