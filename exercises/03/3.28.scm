(load "lib/queue.scm")
(load "lib/simulator.scm")

(define (or-gate a1 a2 output)
  (define (logical-or x y)
    (if (or (= 1 x) (= 1 y))
      1
      0))
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal a1)
                                  (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda () 
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  "ok")


;  test or-gate

(define a (make-wire))
(define b (make-wire))
(define s (make-wire))
(define c (make-wire))


(get-signal a)
(or-gate a b c)
(set-signal! a 1)
(propagate)
(get-signal c)
;Value: 1
(set-signal! a 0)
(propagate)
(get-signal c)
;Value: 0