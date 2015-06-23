
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond 
    ((> (square test-divisor) n) n)
    ((divides? test-divisor n) test-divisor)
    (else (find-divisor n (+ test-divisor 1)))))

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

;(timed-prime-test 199999)
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
1000000007. ---用时--- .07000000000000028
1000000009. ---用时--- .0699999999999994
1000000021. ---用时--- .07000000000000028
1000000033. ---用时--- .0699999999999994
1000000087. ---用时--- .07000000000000028
(search-for-primes 1e10 1e11)
;结果的前几个如下
10000000019. ---用时--- .20999999999999996
10000000033. ---用时--- .20999999999999996
10000000061. ---用时--- .21999999999999975
10000000069. ---用时--- .23000000000000043
10000000097. ---用时--- .21999999999999975

;可以看到，基数增加了10倍，耗时基本上也是3倍的关系
