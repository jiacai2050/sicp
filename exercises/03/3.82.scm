(load "lib/stream.scm")
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define x1 2)
(define y1 4)
(define x2 8)
(define y2 10)

(define (make-point)
  (let ((x (random-in-range x1 x2))
        (y (random-in-range y1 y2)))
    (cons x y)))

(define (make-experiment-stream)
  (cons-stream (make-point)
               (make-experiment-stream)))

(define (in-circle? point)
  (let ((px 5)
        (py 7)
        (radix 3)
        (x (car point))
        (y (cdr point)))
    (< (+ (square (- x px)) (square (- y py))) (square radix))))

(define in-stream (make-experiment-stream))
(define experiment-stream (stream-map in-circle? in-stream))

(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream 
      (let ((sum (+ passed failed)))
        (if (= 0 sum)
          0
          (/ (* 1.0 passed) (+ passed failed))))
      (monte-carlo (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
    (next (+ 1 passed) failed)
    (next passed (+ 1 failed))))


(define pi-stream
  (let ((width (abs (- x1 x2)))
        (height (abs (- y1 y2))))
    (let ((area (* width height)))
      (stream-map
        (lambda (p) (/ (* area p) (square 3)))
        (monte-carlo experiment-stream 0 0)))))

(display-line (stream-ref pi-stream 100))
; 3.0495049504950495
(display-line (stream-ref pi-stream 10000))
; 2.787321267873213

; 估计是随机数产生的问题，我这里算出的 pi 值与 3.14 相差较远，情况与习题 3.6 一样