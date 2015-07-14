## 内容

找零钱迭代算法

## 笔记

- 今天公司野外扩展第二天，累的像狗，看了下找零钱的迭代算法

这个题目算是头脑风暴，网上能找到的答案也不尽相同，核心思想就是通过构筑尾递归或者memorize来消除重复计算的问题。

较为详细的参考：http://c2.com/cgi/wiki?SicpIterationExercise

```
 (define (count-change-iter amount)
    (cc-fifties amount 0))

 (define (cc-fifties amount acc)
    (cond ((= amount 0) (+ 1 acc))
     ((< amount 0) acc)
     (else (cc-fifties (- amount 50)
                (cc-quarters amount acc)))))

 (define (cc-quarters amount acc)
    (cond ((= amount 0) (+ 1 acc))
     ((< amount 0) acc)
     (else (cc-quarters (- amount 25)
             (cc-dimes amount acc)))))

 (define (cc-dimes amount acc)
    (cond ((= amount 0) (+ 1 acc))
     ((< amount 0) acc)
     (else (cc-dimes (- amount 10)
             (cc-nickels amount acc)))))

 (define (cc-nickels amount acc)
    (cond ((= amount 0) (+ 1 acc))
     ((< amount 0) acc)
     (else (cc-nickels (- amount 5)
                (cc-pennies amount acc)))))

 (define (cc-pennies amount acc)
    (cond ((= amount 0) (+ 1 acc))
     ((< amount 0) acc)
     (else (cc-pennies (- amount 1)
                (cc-nothing amount acc)))))

 (define (cc-nothing amount acc)
    acc)
```
这里的主要思想是把树型递归，改为尾递归的形式，而编译器可以优化尾递归为迭代，使得空间复杂度为`O(1)`，但是这里貌似时间复杂度并没有变，因为计算`(cc money kind)`时，还是由

- `(cc (- account (domination-of-kind k)))`
- `(cc account (- k 1))`

这两部分组成的。