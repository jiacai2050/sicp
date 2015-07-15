
;这道题目后面还让我们用百分比的方式给出区间表示
(define (make-center-percent c p)
  (make-center-width c (* c p)))

(define (percent i)
  (- (/ (upper-bound i) (center i)) 1))