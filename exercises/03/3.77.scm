(load "lib/stream.scm")

; 这是书中正文给出的版本，隐式风格的版本
(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-streams (scale-stream integrand dt)
                                int))))
  int)

; 这是与 integers-starting-from 对应的版本
(define (integral2 delayed-integrand initial-value dt)
  (cons-stream initial-value
    (let ((integrand (force delayed-integrand)))
      (if (stream-null? integrand)
        the-empty-stream
        (integral2 (delay (stream-cdr integrand))
                    (+ (* dt (stream-car integrand))
                       initial-value)
                    dt)))))



(define (solve f y0 dt)
  (define y (integral2 (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

(stream-ref (solve (lambda (y) y) 1 0.001) 1000)
;Value: 2.716923932235896