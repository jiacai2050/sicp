(define count 0)

(define (id x)
  (set! count (+ count 1))
  x)

(define w (id (id 10)))

count
; 1
; define 时外层的 id 会被调用

w
; 10
; 对 w 求值，会导致内层的 id 会被调用，所以这是 count 为 2

count
; 2  
