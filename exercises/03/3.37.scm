; cel-fah-converter 的基本形式可以参考 lib/cel-fah-converter
; https://github.com/jiacai2050/sicp/blob/master/exercises/03/lib/cel-fah-converter.scm

(load "lib/propagation.scm")

; 9C = 5(F-32)
; F = 9C/5 + 32

(define (cel-fah-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))
(define (c- x y)
  (let ((z (make-connector)))
    (adder y z x)
    z))
(define (c* x y)
  (let ((z (make-connector)))
    (multiplier x y z)
    z))
(define (c/ x y)
  (let ((z (make-connector)))
    (multiplier y z x) 
    z))
(define (cv x)
  (let ((z (make-connector)))
    (constant x z)
    z))

(define C (make-connector))
(define F (cel-fah-converter C))
(probe 'cel C)
(probe 'fah F)

(set-value! C 25 'user)
; Probe: cel = 25
; Probe: fah = 77

(forget-value! C 'user)
; Probe: cel = ?
; Probe: fah = ?

(set-value! C 35 'user)
; Probe: cel = 35
; Probe: fah = 95