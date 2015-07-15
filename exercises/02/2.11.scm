;解决这题，首先要明确题目说的9种是怎么形成的，无非就是区间大于0，小于0，横跨0，这三种情况，然后两个区间组合的话，就有9种了。
;其中，两个区间都横跨0的情况，应该是乘法步骤最多的。
;明确上面两点，程序就不难写了。
(define (mul-interval x y)
  (cond
    ((< 0 (upper-bound x))  ; x小于0
      (cond 
        ((< 0 (upper-bound y))  ; y小于0
          (make-interval (* (lower-bound x) (lower-bound y))
                         (* (upper-bound x) (upper-bound y))))
        ((< 0 (/ (upper-bound y) (lower-bound y)))  ; y横跨0
          (make-interval (* (lower-bound x) (lower-bound y))
                         (* (lower-bound x) (upper-bound y))))
        (else
          (make-interval (* (lower-bound x) (upper-bound y))
                         (* (upper-bound x) (lower-bound y))))))
    ((< 0 (/ (upper-bound x) (lower-bound x)))  ; x横跨0
      (cond 
        ((< 0 (upper-bound y))  ; y小于0
          (make-interval (* (upper-bound x) (lower-bound y))
                         (* (lower-bound x) (lower-bound y))))
        ((< 0 (/ (upper-bound y) (lower-bound y)))  ; y横跨0
          (make-interval (min (* (lower-bound x) (upper-bound y)) (* (upper-bound x) (lower-bound y)))
                         (max (* (lower-bound x) (lower-bound y)) (* (upper-bound x) (upper-bound y)))))
        (else
          ;这里懒的写了，抽空后面补上
          )))
    (else ; x大于0
      ;这里懒的写了，抽空后面补上
      )))

;大家也可以看出来，改成这样子，好麻烦！
