;我们应该只删除环境中第一个框架的约束
;因为 make-unbound! 需要与 define 对应起来


(define (make-unbound! var env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars) 'OK)
            ((eq? var (car vars))
              (set-car! vals (cdr vals))
              (set-car! vars (cdr vars)))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))
