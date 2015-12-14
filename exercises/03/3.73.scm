(load "lib/stream.scm")

(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                             int)))
  int)

(define (RC R C dt)
  (lambda (current-stream v0)
    (add-streams (scale-stream current-stream R)
                 (integral (scale-stream current-stream (/ 1.0 C))
                           v0
                           dt))))

(define RC1 (RC 5 1 0.5))

(define voltage-stream (RC1 integers 1))

(display-top10 voltage-stream)

; 6  11.5  17.5  24.  31.  38.5  46.5  55.  64.  73.5