;(a)
(define (cont-frac n d k)
  (define (iter index)
    (if (> index k)
      0
      (/ (n index) (+ (d index) (iter (+ index 1))))))
  (iter 1))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           10)

;这里要使结果精度在小数点后4位，依次试验即可。
;(b)
(define (cont-frac2 n d k)
  (define (iter index result)
    (display index)
    (newline)
    (if (> 1 index)
      result
      (iter (- index 1) (/ (n index)
                           (+ (d index) result)))))
  (iter k 0))

(cont-frac2 (lambda (i) 1.0)
           (lambda (i) 1.0)
           100)