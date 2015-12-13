; Louis Reasoner 建议改进 sqrt-stream 为如下更直截了当的形式
; 原方式可以 ../lib/exploit_stream.scm 中找到

(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess) (sqrt-import guess x))
                           (sqrt-stream x))))

; 这样在 stream-map 中多调用了次 sqrt-stream，而且这个 (sqrt-stream x) 与原始过程的 (sqrt-stream x) 代表不同的流，所以会进行重复计算。
; 如果不用 memo-proc 提供优化，对上面这个过程来说影响不大，因为它都要重新计算 x 之前的元素。