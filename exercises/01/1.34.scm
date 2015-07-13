
(define (f g)
  (g 2))

(f square)
;Value: 4
(f (lambda (z) (* z (+ z 1))))
;Value: 6

(f f)
;报错，The object 2 is not applicable.
;因为这里(f f)的展开过程如下：
(f f) 
;---->
(f 2)
;---->
(2 2)
;而这里的2不是一个过程名，所以出错。
