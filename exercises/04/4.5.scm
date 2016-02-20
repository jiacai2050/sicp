(define (extended-cond? clause) 
 (eq? (cadr (cond-actions clause)) '=>)) 

(define (extended-cond-actions clause) 
 (caddr clause))

(define (expand-clauses clauses)
  (if (null? clauses)
    false
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (cond-else-clause? first)
        (if (null? rest)
          (sequence->exp (cond-actions first)) 
          (error "ELSE clause isn't last -- CONF->IF" clause))
        (if (extended-cond? first)
          (make-if (cond-predicate first)
                   (list (extended-cond-actions first) (cond-predicate first))
                   (expand-clauses rest))
          (make-if (cond-predicate first)
                   (sequence->exp (cond-actions first))
                   (expand-clauses rest)))))))


; 上面这种方式 (cond-predicate first) 在扩展的情况下，被运行了两次，
; 一次用于检查条件是否为真时；
; 另一次在作为参数传入 recipient 时

; 解决方法也很简单，把 (cond-predicate first) 作为一个 lambda 的参数传入，这样可以实现类似 let 的绑定效果

(define (make-application function parameters) 
  (cons function parameters))

(define (expand-clauses clauses) 
  (if (null? clauses) 
    'false                          ; no else clause 
    (let ((first (car clauses)) 
          (rest (cdr clauses))) 
      (if (cond-else-clause? first) 
        (if (null? rest) 
          (sequence->exp (cond-actions first))
          (error "ELSE clause isn't last -- COND->IF" clauses))
        (if (extended-cond? first) 
          (make-application (make-lambda '(_cond-parameter) 
                                          (make-if _cond-parameter 
                                                   (make-application (extended-cond-actions first) 
                                                                     _cond-parameter) 
                                                   (expand-clauses rest))) 
                            (cond-predicate first))
          (make-if (cond-predicate first) 
                   (sequence->exp (cond-actions first)) 
                   (expand-clauses rest)))))))


; 参见：http://community.schemewiki.org/?sicp-ex-4.5