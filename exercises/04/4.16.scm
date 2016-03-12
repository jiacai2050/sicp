; a)
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
              (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
              (if (eq? '*unassigned* (car vals))
                (error "Can't access '*unassigned* value " var)
                (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable " var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))

; b)
(define (scan-out-defines proc)
  (define (make-unassigned-binding variables)
    (map (lambda (var) (cons var '*unassigned*)) variables))
  (define (iter body non-define-clauses variables set-clauses)
    (if (null? body)
      (make-let (make-unassigned-binding variables)
                (append set-clauses non-define-clauses))
      (let ((first-clause (first-exp body)))
        (if (define? first-clause)
          (iter (rest-exps body)
                non-define-clauses
                (cons (definition-variable first-clause) variables)
                (list set! (definition-variable first-clause) (definition-value first-clause)))
          (iter body
                (cons first-clause non-define-clauses)
                variables
                set-clauses)))))
  (let (body (lambda-body proc))
    (iter body '() '() '())))

; c)

;在 make-procedure 里面添加相当于在定义 lambda 时就处理好内部定义了
;在 procedure-body 里面添加相当于在应用 lambda 时再处理内部定义
;
;具体采用哪种形式的定义，可以根据语言的使用场景来，如果 lambda 定义多而应用少，那么可以在 procedure-body 里面添加，反之，可以在 make-procedure 里添加。
