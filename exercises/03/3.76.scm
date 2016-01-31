(define (smooth input-stream)
  (define (average x y)
    (/ (+ x y) 2))
  (cons-stream
    (average (stream-car input-stream) (stream-car (stream-cdr input-stream)))
    (smooth (stream-cdr input-stream))))

(define (make-zero-crossings input-stream smooth)
  (define (iter s last-value)
    (cons-stream (sign-change-detector (stream-car s) last-value)
                 (iter (stream-cdr s) (stream-car s))))
  (iter (smooth input-stream) 0))
; 或者下面这种形式
(define (make-zero-crossings input-stream smooth)
  (let ((smooth-stream (smooth input-stream)))
    (stream-map sign-change-detector smooth-stream (cons-stream 0 smooth-stream))))
