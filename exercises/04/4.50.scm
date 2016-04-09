(define (remove-from x xs)
  (cond ((null? xs) null)
        ((equal? x (car xs)) (cdr xs))
        (else (cons (car xs) (remove-from x (cdr xs))))))

(define (any l)
  (list-ref l (random (length l))))


(define (analyze-ramb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
          (fail)
          (let ((current-choice (any choices)))
            (current-choice env
                            succeed
                            (lambda ()
                              (try-next (remove-from current-choice choices)))))))
      (try-next cprocs))))


(define (analyze exp)
...
...
  ((ramb? exp) (analyze-ramb exp))
...)

(define (ramb? exp) (tagged-list? exp 'ramb))
(define (ramb-choices exp) (cdr exp))
