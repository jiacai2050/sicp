(let ((a 1))
  (define (f x)
    (define b (+ a x))
    (define a 5)
    (+ a b))
  (f 10))

;Premature reference to reserved name: a

; 这里的难点在于同时定义 a 与 b，这基本上是不可能的，因为 b 的值依赖 a，没有办法做到同时赋值
