(load "keyword.scm")

; 变量用符号表示
(define (variable? exp) (symbol? exp))
; 引号表达式 (quote <text-of-quotation>)
(define (quoted? exp)
  (tagged-list? exp 'quote))
(define (text-of-quotation exp)
  (cadr exp))


; begin 表达式
(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))

; 序列 ---> begin 表达式
(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))

; 过程应用
(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))


; cond ---> if
; cond 表达式借助 if 表达式实现，这种采用语法变换的方式实现的表达式称为派生表达式，let 也是派生表达式。

(define (cond? exp) (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause)
  (eq? 'else (cond-predicate clause)))

(define (cond-predicate clause) (car clause))

(define (cond-actions clause) (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
    false
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (cond-else-clause? first)
        (if (null? rest)
          (sequence->exp (cond-actions first))
          (error "ELSE clause isn't last -- CONF->IF" clauses))
        (make-if (cond-predicate first)
                 (sequence->exp (cond-actions first))
                 (expand-clauses rest))))))

; 实际的 Lisp 系统提供了一种机制，使用户可以添加新的派生表达式并将它们的实现描述为语法变换，而又不必修改求值器。
; 这种用户定义称为 宏。
; 虽然很容易为提供宏增加一种基本机制，但是这样做出的语言却会产生一种微妙的名字冲突问题。
; 一些研究：
; Eugene Kohlbecker, 1986。http://www.ccs.neu.edu/racket/pubs/dissertation-kohlbecker.pdf
; https://www.reddit.com/r/scheme/comments/dggo1/syntactic_extensions_in_the_programming_language/


; 谓词检测
(define (true? x)
  (not (eq? x false)))
(define (false? x)
  (eq? x false))

; 过程的表示

;(apply-primitive-procedure <proc> <args>)
;(primitive-procedure? <proc>)

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (procedure-parameters p)
  (cadr p))
(define (procedure-body p)
  (caddr p))
(define (procedure-environment p)
  (cadddr p))

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))
(define (primitive-implementation proc)
  (cadr proc))
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '+ +)
        (list '- -)
        (list '* *)
        (list '/ /)))
(define (primitive-procedure-names)
  (map car primitive-procedures))
(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))

(define apply-in-underlying-scheme apply)
(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme (primitive-implementation proc) args))
