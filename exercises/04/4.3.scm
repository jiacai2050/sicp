; 基于数据导向的设计方式，主要就是对每种类型加一个 tag 标示，
; 然后将不同类型的同一操作放入一个 table 中，
; 最后根据输入数据的类型来动态获取实际的操作

(load "lib/interpreter.scm")
(load "../02/lib/hash_table.scm")

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((get (exp-type exp)) (exp-body exp) env)
        ((application? exp)
          (apply (eval (operator exp) env)
                 (list-of-values (operands exp) env)))
        (else (error "Unknow exp" exp))))

(define (exp-type exp) (car exp))
(define (exp-body exp) (cdr exp))


(put 'quote text-of-quotation)
(put 'set! eval-assignment)
(put 'define eval-definition)
(put 'if eval-if)
(put 'lambda (lambda (exp env) (make-procedure (lambda-parameters exp) (lambda-body exp) env)))
(put 'begin (lambda (exp env) (eval-sequence (begin-sequence exp) env)))
(put 'cond (lambda (exp env) (eval (cond->if exp) env)))


; (define (install-if-package)
;   (define (eval-if exp env)
;     (if (true? (eval (if-predicate exp) env))
;       (eval (if-consequent exp) env)
;       (eval (if-alternative exp) env)))

;   (define (if-predicate exp) (cadr exp))
;   (define (if-consequent exp) (caddr exp))
;   (define (if-alternative exp)
;     (if (not (null? cdddr exp))
;       (cadddr exp)
;       'false))
;   ; 外部接口
;   (define (tag x) (cons 'if x))
;   (put 'if eval-if))
