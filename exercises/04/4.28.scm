(define (add a b)
  (+ a b))

(add 1 2)

; 如果这里我们不对 add 进行 force-it，那么它的值就是个trunk，这时是无法进行过程调用的。
