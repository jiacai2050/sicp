; 可以用下面的例子说明 squarer 会出现什么问题

(load "lib/propagation.scm")

(define (squarer a b)
  (multiplier a a b))

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
; Probe: b = 9

(get-value a)
;Value: 3

; 可以看到，这里的 a 的值还是为 3，这是因为 multiplier 里面只有两个数都确定后才能确定出第三个数的值，而如果我们这里仅仅设置了 b 的值，是达不到这种效果的，所以 a 这里还是上次设置的值 3。

