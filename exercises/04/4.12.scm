(define (scan frame var null-callback found-callback)
  (let ((vars (frame-variables frame))
        (vals (frame-values frame)))
  (cond ((null? vars)
          (null-callback)
        ((eq? var (car vars))
          (found-callback vals))
        (else (scan (cdr vars) (cdr vals)))))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
      (error "Unbound variable " var)
      (scan (first-frame env)
            var
            (lambda () (env-loop (enclosing-environment env)))
            (lambda (vals) (cdr vals)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
      (error "Unbound variable " var)
      (scan (first-frame env)
            var
            (lambda () (env-loop (enclosing-environment env)))
            (lambda (vals) (set-car! vals val)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (scan frame
          var
          (lambda () (add-binding-to-frame! var val frame))
          (lambda (vals) (set-car! vals val)))))
