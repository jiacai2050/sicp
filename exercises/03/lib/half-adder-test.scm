(load "queue.scm")
(load "simulator.scm")


(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))
(probe 'sum sum)
; sum  0 New-value = 0
(probe 'carry carry)
; carry  0 New-value = 0

(half-adder input-1 input-2 sum carry)
;Value: "ok"
(set-signal! input-1 1)
;Value: "done"
 (propagate)
; ;sum  8 New-value = 1

(newline)
(set-signal! input-2 1)
(propagate)
; carry  11 New-value = 1
; sum  16 New-value = 0