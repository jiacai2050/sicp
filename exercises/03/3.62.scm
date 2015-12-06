(load "3.61.scm")

(define (div-series s1 s2)
  (mul-series s1 (reciprocal-series s2)))


(define tangent-series
  (div-series sine-series cosine-series))


(for-each (lambda (x) (display-blank (stream-ref tangent-series x))) (range 0 10))
(newline)
; 0 1 0 1/3 0 2/15 0 17/315 0 62/2835

; 关于tan的级数，可以参考 Wikipedia
; https://en.wikipedia.org/wiki/Trigonometric_functions#Tangent