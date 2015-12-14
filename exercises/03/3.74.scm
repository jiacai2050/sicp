
(define (sign-change-detector current last)
  ; 首先检查两个值是否为异号
  (if (> (/ current last) 0)
    0
    ; 在异号情况下，检查变化趋势
    (if (> current 0)
      -1
      1)))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
    (sign-change-detector (stream-car input-stream) last-value)
    (make-zero-crossings (stream-cdr input-stream) (stream-car input-stream))))

(define zero-crossings (make-zero-crossings sense-data 0))

(define zero-crossings
  (stream-map sign-change-detector sense-data (cons-stream 0 sense-data)))

; 第一次写成了下面这种形式
; (stream-cdr sense-data)
; 其实它第一个元素是与 0 比较的