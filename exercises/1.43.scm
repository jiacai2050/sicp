(define (repeated f n)
  (if (= n 1)
    f
    (lambda (x)
      (f ((repeated f (- n 1)) x)))))

((repeated square 2) 5)
;Value: 625


;使用compose方法来构造repeated
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated2 f n)
  (if (= n 1)
    f
    (compose f (repeated f (- n 1)))))
((repeated2 square 2) 5)
;Value: 625