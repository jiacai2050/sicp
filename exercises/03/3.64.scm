(load "lib/stream.scm")
(load "lib/exploit_stream.scm")

(define (stream-limit s tolerance)
  (define (iter s)
    (let ((first (stream-car s))
          (second (stream-car (stream-cdr s))))
      (if (< (abs (- first second)) tolerance)
        second
        (iter (stream-cdr s)))))
  (iter s))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(define tolerance 0.000000001)

; 检查结果是否在允许误差内
(< (abs (- 2 (square (sqrt 2 tolerance)))) tolerance)

;Value: #t