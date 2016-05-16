(define (fib n)
  (if (< n 2)
    n
    (+ (fib (- n 1))
       (fib (- n 2)))))

(controller
  (assign continue (label fib-done))
fib-loop
  (test (op <) (reg n) (const 2))
  (branch (label immediate-answer))
  ;; set up to compute Fib(n-1)
  (save continue)
  (assign (continue (label afterfib-n-1))
  (save n)                                ; save old value of n
  (assign n (op -) (reg n) (const 1)))    ; clobber n to n-1
  (goto (label fib-loop))                 ; perform recursive call
afterfib-n-1                              ; upon return, val contains Fib(n-1)
  (restore n)
  (restore continue)                      ; 这里可以删除
  ;; set up to compute Fib(n-2)
  (assign n (op -) (reg n) (const 2))
  (save continue)                         ; 这里可以删除
  (assign continue (label afterfib-n-2))
  (save val)                               ; save Fib(n-1)
  (goto (label fib-loop))
afterfib-n-2                               ; upon return, val contains Fib(n-2)
  (assign n (reg val))                     ; n now contains Fib(n-2)
  (restore val)                            ; val now contains Fib(n-1)
  (restore continue)
  (assign val (op +) (reg val) (reg n))    ; return to caller, answer is in val
  (goto (reg continue))
immediate-answer
  (assign val (reg n))                     ; base case: Fib(n) = n
  (goto (reg continue))
fib-done)

;; afterfib-n-1 中先把 continue 释放，然后又保存起来，中间什么操作也没有
