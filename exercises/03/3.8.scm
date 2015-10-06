(define (make-f)
  (let ((seed 2))
    (lambda (x)
      (set! seed (- seed 1))
      (* x seed))))

(define f (make-f))

; left -> right
(define f0 (f 0))
(define f1 (f 1))
(+ f0 f1)
;Value: 0

(define f (make-f))
(define f1 (f 1))
(define f0 (f 0))
(+ f0 f1)
;Value: 1