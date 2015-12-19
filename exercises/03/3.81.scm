; 代码参考 https://wqzhang.wordpress.com/2009/09/10/sicp-exercise-3-81/
; 它这里用了 http://en.wikipedia.org/wiki/Linear_congruential_generator
; 来生成随机数

(load "lib/stream.scm")
(define (rand-update x)
  (let ((a (expt 2 32))
        (c 1103515245)
        (m 12345))
    (modulo (+ (* a x) c) m)))

(define random-init 137)
(define (random-numbers s-in)
  (define (action x m)
    (cond ((eq? m 'generate)
           (rand-update x))
          (else m)))
  (cons-stream 
    random-init
    (stream-map action (random-numbers s-in) s-in)))

; test
(define cmds
  (cons-stream 'generate 
               (cons-stream 'generate
                            (cons-stream 'generate
                                         (cons-stream 'generate '())))))

(define s0 (random-numbers cmds))

(stream-ref s0 0)
;Value: 137
(stream-ref s0 1)
;Value: 3062
(stream-ref s0 2)
;Value: 1397
(stream-ref s0 3)
;Value: 9182
(stream-ref s0 4)
;Value: 1142

(define cmds
  (cons-stream 'generate 
               (cons-stream 'generate
                            (cons-stream 137
                                         (cons-stream 'generate '())))))

(define s1 (random-numbers cmds))
(stream-ref s1 0)
;Value: 137
(stream-ref s1 1)
;Value: 3062
(stream-ref s1 2)
;Value: 1397
(stream-ref s1 3)
;Value: 137
(stream-ref s1 4)
;Value: 3062