(load "lib/propagation.scm")


(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
      (if (< (get-value b) 0)
        (error "square less than 0 -- SQUARER" (get-value b))
        (set-value! a (sqrt (get-value b)) me))
      (if (has-value? a)
        (let ((val (get-value a)))
          (set-value! b (* val val) me)))))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (process-new-value))
  (define (me request)
    (cond
      ((eq? request 'I-have-a-value) (process-new-value))
      ((eq? request 'I-lost-my-value) (process-forget-value))
      (else
        (error "Unknown request -- SQUARER" request))))
  (connect a me)
  (connect b me))


(define a (make-connector))
(define b (make-connector))

(squarer a b)
(probe 'a a)
(probe 'b b)

(set-value! a 3 'ljc)
; Probe: a = 3
; Probe: b = 9

(forget-value! a 'ljc)
; Probe: a = ?
; Probe: b = ?

(set-value! b 4 'ljc)
; Probe: b = 4
; Probe: a = 2

; 这里看到 a 已经为 2，和习题 3.34 不一样