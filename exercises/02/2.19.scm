(define (cc amount coin-values)
  (cond
    ((= amount 0) 1)
    ((or (no-more? coin-values) (< amount 0)) 0)
    (else
      (+ (cc (- amount (first-denomination coin-values)) coin-values)
         (cc amount (except-first-denomination coin-values))))))

(define (no-more? coin-values)
  (null? coin-values))
(define (first-denomination coin-values)
  (car coin-values))
(define (except-first-denomination coin-values)
  (cdr coin-values))


(define (start-test coins)
  (let ((s (runtime)))
    (cc 400 coins)
    (newline)
    (display (- (runtime) s))
    (newline)))

(start-test (list 50 25 10 5 1))
;耗时：3.200000000000003
(start-test (list 1 5 10 25 50))
;耗时：5.109999999999999
(start-test (list 10 25 1 5 50))
;耗时：4.8500000000000085

;变换硬币顺序不能影响cc的正确性，因为cc会便利每一个硬币；
;但是改变硬币顺序后，能够影响cc的时间。
