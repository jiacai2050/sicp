; 我觉得这个题目挺直接的，Alyssa 想要的是 sense-data 流中前后两个值的平均值，而不是上次求的平均值与当前值的平均值

(define (make-zero-crossings input-stream last-value last-avpt-value)
  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
    (cons-stream
      (sign-change-detector last-avpt-value avpt)
      (make-zero-crossings (stream-cdr input-stream) (stream-car input-stream) avpt))))