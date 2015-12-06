(load "lib/stream.scm")


(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den)
            den
            radix)))

(define foo (expand 1 7 10))
(define bar (expand 3 8 10))

(for-each (lambda (x) (display-blank (stream-ref foo x))) (range 0 20))
; 1 4 2 8 5 7 1 4 2 8 5 7 1 4 2 8 5 7 1 4
(newline)
(for-each (lambda (x) (display-blank (stream-ref bar x))) (range 0 20))
; 3 7 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

; expand 的作用就是把小于1的分数转化为小数，分子是 num（numerator），分母时 den（denominator），radix 表示进制
; expand 的返回的流即为 num/den 转化为小数后小数点后的数字序列