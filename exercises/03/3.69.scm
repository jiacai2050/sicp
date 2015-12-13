(load "lib/stream.scm")

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))


(define (triples s t u)
  (cons-stream (list (stream-car s) (stream-car t) (stream-car u))
    (interleave
      (stream-map 
        (lambda (x) (cons (stream-car s) x))
        (pairs t (stream-cdr u)))
      (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))

(define p (triples integers integers integers))
(display-top10 p)
; (1 1 1)  (1 1 2)  (2 2 2)  (1 1 3)  (2 2 3)  (1 2 3)  (3 3 3)  (1 1 4)  (2 2 4)  (1 2 4)
(define triangles
  (stream-filter
    (lambda (triple) (= (+ (square (car triple))
                           (square (cadr triple)))
                        (square (caddr triple))))
    p))
(display-top10 triangles)
; (3 4 5)  (6 8 10)  (5 12 13)  (9 12 15)  (8 15 17)  (12 16 20)
;    ... aborted
;Aborting!: out of memory
;GC #60: took:   0.23  (50%) CPU time,   0.24  (50%) real time; free: 5188
;GC #61: took:   0.22  (96%) CPU time,   0.24 (100%) real time; free: 5254

; 这里的思想和二维的差不多，只不过这里多了一维，不过再算毕达哥拉斯三元组时，在算完前几个后就报错了。
; 这里报的是内存不够，我们知道在 delay 部分求值后，会调用 memo-proc 将之缓存起来，估计这里需要算个数据太大，内存里面放不下了。