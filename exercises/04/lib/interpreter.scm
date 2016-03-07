(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
          (make-procedure (lambda-parameters exp)
                          (lambda-body exp)
                          env))
        ((begin? exp)
          (eval-sequence (begin-actions exp) env))
        ((cond? exp)
          (eval (cond->if exp) env))
        ((application? exp)
          (apply (eval (operator exp) env)
                 (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL " env))))

; 这里将 eval 实现为一个采用 cond 的分情况分析。这样做的缺点是我们的过程只处理了若干种不同类型的表达式。
; 在大部分的 Lisp 实现里，针对表达式类型的分派都采用了数据导向的方式。这样用户可以更容易增加 eval 能分辨的表达式类型，而又不必修改 eval 的定义本身。


(define (apply procedure arguments)
  (cond ((primitive-procedure? procedure)
          (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
          (eval-sequence
            (procedure-body procedure)
            (extend-environment (procedure-parameters procedure)
                                arguments
                                (procedure-environment procedure))))
        (else
          (error "Unknown procedure type --  APPLY " procedure))))

; 过程参数，eval 使用

(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (cons (eval (first-operand exps) env)
          (list-of-values (rest-operands exps) env))))

; 条件

(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
    (eval (if-consequent exp) env)
    (eval (if-alternative exp) env)))

; 序列，可以用在 apply 用于求值过程体里的表达式序列，也可以用在 eval 求值 begin 表达式里面的表达式序列

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (eval (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

; 赋值和定义

(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (eval (assignment-value exp) env)
                       env)
  'ok)

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
                    (eval (definition-value exp) env)
                    env)
  'ok)

; 4.2 表达式的表示

; 自求值表达式
(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))
; 变量用符号表示
(define (variable? exp) (symbol? exp))
; 引号表达式 (quote <text-of-quotation>)
(define (quoted? exp)
  (tagged-list? exp 'quote))
(define (text-of-quotation exp)
  (cadr exp))
(define (tagged-list? exp tag)
  (if (pair? exp)
    (eq? (car exp) tag)
    false))
; 赋值的形式 (set! <var> <value>)
(define (assignment? exp)
  (tagged-list? exp 'set!))
(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))
; 定义的形式
(define (definition? exp)
  (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
    (cadr exp)
    (caadr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
    (cadr exp)
    (make-lambda (cdadr exp)
                 (cddr exp))))

; lambda 表达式是由符号 lambda 开始的表

(define (lambda? exp) (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))

(define (lambda-body exp) (cddr exp))

; lambda 构造函数
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

; if 条件式

(define (if? exp) (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp)
  (if (not (null? cdddr exp))
    (cadddr exp)
    'false))

; if 构造函数

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

; begin 表达式
(define (begin? exp) (tagged-list? exp 'begin))

(define (begin-actions exp) (cdr exp))

(define (last-exp? seq) (null? (cdr seq)))

(define (first-seq exp) (cdr seq))

(define (rest-exps exp) (cdr exp))

; 序列 ---> begin 表达式

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-seq seq))
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
          (error "ELSE clause isn't last -- CONF->IF" clause))
        (make-if (cond-predicate first)
                 (sequence->exp (cond-actions first))
                 (expand-clauses rest))))))

; 实际的 Lisp 系统提供了一种机制，使用户可以添加新的派生表达式并将它们的实现描述为语法变换，而又不必修改求值器。
; 这种用户定义称为 宏。
; 虽然很容易为提供宏增加一种基本机制，但是这样做出的语言却会产生一种微妙的名字冲突问题。
; 一些研究：
; Eugene Kohlbecker, 1986。http://www.ccs.neu.edu/racket/pubs/dissertation-kohlbecker.pdf
; https://www.reddit.com/r/scheme/comments/dggo1/syntactic_extensions_in_the_programming_language/
