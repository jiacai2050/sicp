(define (div-interval x y)
  (if (< 0 (/ (upper-bound y) (lower-bound y)))
    0
    (mul-interval x
                  (make-interval
                    (/ 1.0 (upper-bound y))
                    (/ 1.0 (lower-bound y)))))