(load "3.50.scm")

(define (show x)
  (display-line x)
  x)

(define x (stream-map show (stream-enumerate 0 10)))

; 0

(stream-ref x 5)

; 1
; 2
; 3
; 4
; 5

(stream-ref x 7)

; 6
; 7