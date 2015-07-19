;这个题目需要注意，减法不能用交换律，我第一次想的是尽可能找大范围的区间，而忽略了这一点
(define (sub-interval x y)
  (make-interval
    (- (lower-bound x) (upper-bound y))
    (- (upper-bound x) (lower-bound y))))