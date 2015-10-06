(define (make-rand seed)
  (define (dispatch m)
    (cond
      ((eq? m 'generate)
        (rand-update seed))
      ((eq? m 'reset)
        (lambda (newSeed))
          (reset! seed newSeed))
      (else
        (error "Wrong method: " m))))
  dispatch)

(define rand (make-rand 4))