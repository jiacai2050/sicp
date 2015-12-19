(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond
      ((= 0 trials-remaining) (/ trials-passed trials))
      ((experiment)
        (iter (- trials-remaining 1) (+ trials-passed 1)))
      (else (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (make-cesaro-test p x1 x2 y1 y2)
  (lambda ()
    (let ((x (if (> x1 x2) (random-in-range x2 x1) (random-in-range x1 x2)))
          (y (if (> y1 y2) (random-in-range y2 y1) (random-in-range y1 y2))))
      (p x y))))

(define (estimate-integral p x1 x2 y1 y2 trials)
  (let ((width (abs (- x1 x2)))
        (height (abs (- y1 y2))))
    (* width height (monte-carlo trials (make-cesaro-test p x1 x2 y1 y2)))))


(define (in-circle? x y)
  (let ((px 5)
        (py 7)
        (radix 3))
    (< (+ (square (- x px)) (square (- y py))) (square radix))))

; (2, 4) (8, 10) 为长方形一对角线的两个顶点
(estimate-integral in-circle? 2 8 4 10 1000.0)
;Value: 24.336000000000002
;Value: 25.991999999999997
;Value: 25.092
;....      
; 多调用几次，基本保持在25附近
(define (estimate-pi)
  (let ((area (estimate-integral in-circle? 2 8 4 10 1000.0)))
    (/ area (square 3))))

(estimate-pi)
;Value: 2.784
;Value: 2.784
; ....
; 基本保持在 2.8 附近
; 估计是随机数产生的问题，我这里算出的 pi 值与 3.14 相差较远，情况与习题 3.82 一样