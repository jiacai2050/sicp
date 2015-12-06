(load "lib/stream.scm")

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
    the-empty-stream
    (cons-stream
      (apply proc (map stream-car argstreams))
      ;(stream-map proc (map stream-cdr argstreams))  ; 这里不能写成这样
      (apply stream-map (cons proc
                              (map stream-cdr argstreams))))))



(define a (stream-enumerate 1 4))
(define b (stream-enumerate 2 5))
(define c (stream-enumerate 3 6))

(define z (stream-map + a b c))


(display-stream z)

; 6
; 9
; 12
; 15