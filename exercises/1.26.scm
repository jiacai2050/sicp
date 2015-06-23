```
;原始版本
(define (expmod base exp m)
  (cond 
    ((= exp 0) 1)
    ((even? exp)
      (remainder (square (expmod base (/ exp 2) m)) 
                 m))
    (else
      (remainder (* base (expmod base (- exp 1) m))
                 m))))

;Louis Reasoner版本
(define (expmod base exp m)
  (cond 
    ((= exp 0) 1)
    ((even? exp)
      (remainder (* (expmod base (/ exp 2) m)
                    (expmod base (/ exp 2) m))
                 m))
    (else
      (remainder (* base (expmod base (- exp 1) m))
                 m))))
```
Louis Reasoner版本的程序使得之前为对数形递归的程序变成了树形递归，而树形递归的时间复杂度一般是树的高度，本题也不例外。