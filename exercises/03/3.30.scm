(load "lib/queue.scm")
(load "lib/simulator.scm")

; (full-adder a b c-in sum c-out)

(define (ripple-carry-adder a1-list a2-list sum-list c)
  (define (iter a1-rev-list a2-rev-list sum-rev-list c-in)
    (if (not (null? a1-rev-list))
      (let ((c-out (make-wire)))
        (full-adder (car a1-rev-list)
                    (car a2-rev-list)
                    c-in
                    (car sum-rev-list)
                    c-out)
        (iter (cdr a1-rev-list) 
              (cdr a2-rev-list) 
              (cdr sum-rev-list)
              c-out))
      ; 最后将 进位 赋值给 c
      (set-signal! c c-in)))
  (let ((a1-rev-list (reverse a1-list))
        (a2-rev-list (reverse a2-list))
        (sum-rev-list (reverse sum-list)))
    (iter a1-rev-list a2-rev-list sum-rev-list 0)))

; 一个 ripple-carry-adder 的时延 = n * fuller-adder 的时延
; 一个 full-adder 的时延 =  2 * half-adder的时延 + or-gate-delay
; 一个 half-adder 的时延 = max(or-gate-delay, and-gate-delay) + inverter-delay + and-gate-delay
; 所以，一个ripple-carry-adder 的时延 = 2n * (max(or-gate-delay, and-gate-delay) + inverter-delay + and-gate-delay)
;                                     + or-gate-delay*n