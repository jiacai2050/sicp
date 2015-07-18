(load "lib/fermat_prime.scm")

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 100)
    (report-prime n (- (runtime) start-time))))

(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " ---用时--- ")
  (display elapsed-time))

(define (search-for-primes first last) 
  (define (search-iter cur last) 
    (if (<= cur last) (timed-prime-test cur)) 
    (if (<= cur last) (search-iter (+ cur 2) last))) 
  (search-iter (if (even? first) (+ first 1) first) 
               (if (even? last) (- last 1) last)))
;我们可以使用begin快来简化search-iter中的两个if
(define (search-iter cur last) 
  (if (<= cur last) 
    (begin (timed-prime-test cur) 
           (search-iter (+ cur 2) last))))

;由于现在的计算机速度很快，所以我这里把数值调的大一些
;(search-for-primes 1e9 1e10)
;我这里不用用科学计数法，否则程序会报错，传给expmod中的m为浮点数，而remainder要求两个参数都为整数
(search-for-primes 1000000007 1000000087)
;结果的前几个如下
;1000000007 ---用时--- .00999999999999801
;1000000009 ---用时--- 0.
;1000000021 ---用时--- .00999999999999801
;1000000033 ---用时--- 0.
;1000000087 ---用时--- 1.0000000000005116e-2
(search-for-primes 10000000019 10000000097)
;结果的前几个如下
;10000000019 ---用时--- 0.
;10000000033 ---用时--- .00999999999999801
;10000000061 ---用时--- .00999999999999801
;10000000069 ---用时--- 0.
;10000000097 ---用时--- .00999999999999801

;可以看到，测试数据增大了10倍，运行时间基本没怎么变。如果继续扩大数据量，最后应该会是3倍的增长速度，我这里偷个懒，就不给出具体测试数据了。