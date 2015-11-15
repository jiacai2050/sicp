;  (not (x and y)) = (or (not x) (not y))
;  用 a 替换 (not x)， b 替换 (not y)， 可得
;  (not ((not a) and (not b))) = (or a b)


(define (or-gate a1 a2 output)
  (let ((x (make-wire))
        (y (make-wire))
        (z (make-wire)))
    (inverter a1 x)
    (inverter a2 y)
    (and-gate x y z)
    (inverter z output))
  "ok")


; 这里 或门 的延迟时间，主要是 与门 和 非门 的组合，分下面三部
; 1. (inverter a1 x) (inverter a2 y) 同时进行，延迟为 inverter-delay
; 2. (and-gate x y z)，延迟为 and-gate-delay
; 3. (inverter z output)，延迟为 inverter-delay
; 所有，总的 or-gate-delay = 2 * inverter-delay + and-gate-delay