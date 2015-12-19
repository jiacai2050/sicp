
(define (random-update x)  
   (remainder (+ (* 13 x) 5) 24))

(define (make-rand seed)
  (define (dispatch m)
    (cond
      ((eq? m 'generate)
        (let ((new-value (rand-update seed)))
          (reset! seed new-value)
          new-value))
      ((eq? m 'reset)
        (lambda (newSeed))
          (reset! seed newSeed)
          (rand-update seed))
      (else
        (error "Wrong method: " m))))
  dispatch)

(define rand (make-rand 4))


; 下面代码来自
;https://wqzhang.wordpress.com/2009/07/11/sicp-exercise-3-6/
(define (rand-update x)
  (let ((a (expt 2 32))
        (c 1103515245)
        (m 12345))
    (modulo (+ (* a x) c) m)))
(define random-init 137)
(define rand 
  (let ((x random-init))
    (define (dispatch m)
      (cond ((eq? m 'generate)
             (begin (set! x (rand-update x))
                    x))
            ((eq? m 'reset) 
             (lambda (new-x)
               (set! x new-x)))
            (else (error "unknown request"))))
    dispatch))