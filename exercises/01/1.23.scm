
(define (smallest-divisor n)
  (find-divisor n 2))

(define (next test-divisor)
  (if (= 2 test-divisor)
    3
    (+ test-divisor 2)))

(define (find-divisor n test-divisor)
  (cond 
    ((> (square test-divisor) n) n)
    ((divides? test-divisor n) test-divisor)
    (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= 0 (remainder b a)))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
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
(search-for-primes 1e9 1e10)
;结果的前几个如下
1000000007. ---用时--- 3.9999999999999994e-2
1000000009. ---用时--- .03
1000000021. ---用时--- .04999999999999999
1000000033. ---用时--- .03
1000000087. ---用时--- .03999999999999998
(search-for-primes 1e10 1e11)
;结果的前几个如下
10000000019. ---用时--- .10999999999999988
10000000033. ---用时--- .1200000000000001
10000000061. ---用时--- .11999999999999988
10000000069. ---用时--- .13000000000000012
10000000097. ---用时--- .1200000000000001

;对比练习1.22的数据可以看出，耗时基本少了一半。但是并不是严格的两部的关系
;这里主要的问题是我们在调用next函数时，进行if判断时，都需要占用CPU时间片，虽然很短，但是也需要计算在内。
