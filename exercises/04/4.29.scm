; 首先找出一个在没有记忆功能时，比较慢的例子，
; 我们可以简单分析下，慢在哪里。
; 只有对一个延时求值的参数多次求值时才会变慢，所以我们要找的就是一个对参数多次求值的过程。

; 斐波纳契数是个很好的例子，需要说明的是，这里记忆的并不是 (fib n)函数的值，而是记忆的 n 的值
; 如果要实现记忆 (fib n)的值，需要自己写 memorize 函数
(define (fib n)
  (if (< n 1)
    n
    (+ (fib (- n 1))
       (fib (- n 2)))))


;;; L-Eval input:
(square (id 10))
;;; L-Eval value:
100
;;; L-Eval input:
count
;;; L-Eval value:
1 ; with memorization, (id 10) is called once.
2 ; without memorization, (id 10) is called twice
