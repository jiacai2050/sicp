
(define (cont-frac2 n d k)
  (define (iter index result)
    (display index)
    (newline)
    (if (> 1 index)
      result
      (iter (- index 1) (/ (n index)
                           (+ (d index) result)))))
  (iter k 0.0))

(define (tan-cf x k)
  (define (n index) 
    (if (= index 1)
      x
      (- (* x x))))
  (define (d index) 
    (- (* 2 index) 1))
  (cont-frac2 n d k))

(* 1.0 (tan-cf 4 100))
;Value: 1.1578212823495773
(tan 4)
;Value: 1.1578212823495775