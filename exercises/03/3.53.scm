(load "lib/stream.scm")

(define s (cons-stream 1 (add-streams s s)))

; s = 1  2  4  8  16  32....
; 可以看到 s 是2的各个幂组成的流 