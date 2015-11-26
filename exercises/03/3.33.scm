
(load "lib/propagation.scm")

; a + b = 2 * c
(define (averager a b c)
  (let ((bridge (make-connector))
        (const (make-connector)))
    (adder a b bridge)
    (multiplier const c bridge)
    (constant 2 const))
  'ok)

(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(averager a b c)

(probe 'a a)
(probe 'b b)
(probe 'c c)

(set-value! a 4 'user)
(set-value! b 6 'user)

; Probe: a = 4
; Probe: b = 6
; Probe: c = 5

(forget-value! b 'user)
; Probe: b = ?
; Probe: c = ?

(set-value! c 20 'user)

; Probe: c = 20
; Probe: b = 36