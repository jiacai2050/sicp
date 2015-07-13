(define (f n)
  (if (< n 3)
    n
    (+ (f (- n 1))
       (* (f (- n 2)) 2)
       (* (f (- n 3)) 3))))

(define (f2-iter n count a b c)
  (cond 
    ((< n 3) n)
    ((= n count) a)
    (else 
      (f2-iter n (+ count 1) (+ a (* 2 b) (* 3 c)) a b))))

(define (f2 n)
  (f2-iter n 2 2 1 0))
