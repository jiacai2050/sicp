(define (require p)
  (if (not p) (amb)))

(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

(define (analyze-if-fail exp)
  (let ((pproc (analyze (if-predicate exp)))
         (cproc (analyze (if-consequent exp))))
    (lambda (env succeed fail)
      (pproc
        env
        succeed
        (lambda ()
          (cproc env succeed fail))))))


(define (if-fail? exp) (tagged-list? exp 'if-fail))

(define (analyze exp)
...
...
  ((if-fail? exp) (analyze-if-fail exp))
...)
