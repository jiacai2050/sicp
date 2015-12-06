(load "3.50.scm")

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq (stream-map accum (stream-enumerate 1 20)))
;  i   = 1  2  3  4   5   6   7   8   9   10  11  12  13  14   15   16   17   18   19   20
;  seq = 1  3  6  10  15  21  28  36  45  55  66  78  91  105  120  136  153  171  190  210

;  sum = 1
;  这里只需要计算出第一个元素即可。

(define y (stream-filter even? seq))
;  sum = 6 
;  这是因为 stream-filter 会去找到符合 even? 的第一个元素
;  seq 的第一个元素1显然不符合，第二个元素3也不符合，第三个元素6符合

(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
;  sum = 10
;  道理同上，需要找到 符合 (lambda (x) (= (remainder x 5) 0)) 的第一个元素
;  由于 Scheme 中 delay 经过了 memo-proc 处理过了，具有记忆功能，所以前三个元素可以直接取到，不需要再计算
;  这里直接取第四个，即为 10

(stream-ref y 7)
;  sum ＝ 136
;  这里需要注意的是，ref 是从 0 开始的，所以这里实际求的是第八个元素
;  这里取第八个偶数即可，136

(display-stream z)
;  sum ＝ 210
;  这里调用 display-stream 会便利 seq 中所有的元素，所以最终 sum 为 210



; 如果 (delay <exp>) 实现为 (lambda () <exp>) 而不适用 memo-proc，结果很定会和上面的不一样，因为这时在算 y yu z 时起始的元素会被加多边到 sum 中