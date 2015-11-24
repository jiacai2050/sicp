(load "propagation.scm")

(define (cel-fah-converter c f)
  (let ((u (make-connector))
        (v (make-connector))
        (w (make-connector))
        (x (make-connector))
        (y (make-connector)))
    (multiplier c w u)
    (multiplier v x u)
    (adder v y f)
    (constant 9 w)
    (constant 5 x)
    (constant 32 y)
    'ok))

(define C (make-connector))
(define F (make-connector))
(cel-fah-converter c f)

(probe "Cel" C)
(probe "Fah" F)

(set-value! C 25 'user)
; Probe: Cel = 25
; Probe: Fah = 77

(set-value! C 35 'user)
; error Contradction (25 35)

(forget-value! C 'user)
; Probe: Cel = ?
; Probe: Fah = ?

(set-value! C 35 'user)

; Probe: Cel = 35
; Probe: Fah = 95

(forget-value! C 'user2)

;Value: ignore