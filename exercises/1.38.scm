
(define (cont-frac2 n d k)
  (define (iter index result)
    (display index)
    (newline)
    (if (> 1 index)
      result
      (iter (- index 1) (/ (n index)
                           (+ (d index) result)))))
  (iter k 0))

(define (d i)
  (cond
    ((or (= i 1) (= i 2)) i)
    ((= 0 (remainder (- i 2) 3))
      (* 2 (+ 1 (/ (- i 2) 3))))
    (else 1)))
(+ 2
   (cont-frac2 (lambda (i) 1.0)
               d
               100))