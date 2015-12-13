
; 这个题目比我想象中要难些，首先来分析下
; 级数乘积，可以用下面的式子表示（这里只用每个级数的前 3 个元素，其实应该有无穷个）
; (a0 a1 a2) * (b0 b1 b2)
; 要得到乘积后的级数，其实就是把同幂的系数相加就可以了。
; 题目给出的模版为 (cons-stream <??> (add-stream <??> <??>))
; 第一个<??> 比较好填，就是0次幂系数相乘就可以了。即 (* (stream-car s1) (stream-car s2))
; 但是第二个与第三个就不知道怎么填了，先从网上找了个答案，后面理解了再来更新。

(load "3.59.scm")
(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams
                 (add-streams (scale-stream (stream-cdr s1) (stream-car s2))
                              (scale-stream (stream-cdr s2) (stream-car s1)))
                 (cons-stream 0 (mul-series (stream-cdr s1) (stream-cdr s2))))))


(define sum-one (add-streams (mul-series sine-series sine-series)
                             (mul-series cosine-series cosine-series)))

(display-top10 sum-one)
; 1  0  0  0  0  0  0  0  0  0