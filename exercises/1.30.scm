;把sum由线性递归转为迭代形式

;首先给出sum线性递归的形式
(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
        (sum term (next a) next b))))

;下面为sum的迭代形式
(define (sum term a next b)
  (define (sum-iter a result)
    ((if (> a b)
      result
      (sum-iter (next a) (+ result (term a))))))
  (sum-iter a 0)