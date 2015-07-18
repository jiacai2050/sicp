(load "lib/interval.scm")

(define (make-center-width c w)
   (make-interval (- c w) (+ c w)))

(define (center i)
   (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
   (/ (- (upper-bound i) (lower-bound i)) 2))

;这道题目后面还让我们用百分比的方式给出区间表示
(define (make-center-percent c p)
  (make-center-width c (* c (/ p 100.0))))

;这里的center不能为0
(define (percent i)
  (/ (width i) (center i)))