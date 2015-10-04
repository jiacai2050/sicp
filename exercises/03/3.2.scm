(define (make-monitored f)
  (let ((acc 0))
    (lambda (x)
      (cond 
        ((eq? x 'how-many-calls?) acc)
        ((eq? x 'reset-count) (set! acc 0))
        (else (begin (set! acc (+ acc 1))
                     (f x)))))))

(define s (make-monitored sqrt))

(s 100)
;Value: 10
(s 'how-many-calls?)
;Value: 1
(s 100)
;Value: 10
(s 'how-many-calls?)
;Value: 2
(s 'reset-count)
(s 'how-many-calls?)
;Value: 0