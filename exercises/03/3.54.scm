(load "lib/stream.scm")

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials (cons-stream 1 
                                (mul-streams factorials 
                                             (stream-cdr integers))))

(stream-ref factorials 0)
;Value: 1
(stream-ref factorials 1)
;Value: 2
(stream-ref factorials 2)
;Value: 6
(stream-ref factorials 3)
;Value: 24
(stream-ref factorials 4)
;Value: 120


;  第n个元素（从 0 开始数）是 n+1 的阶乘