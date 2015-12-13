
(define (stream-ref s n)
  (if (= 0 n)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
    the-empty-stream
    (cons-stream (proc (stream-car s))
                 (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
    'done
    (begin 
      (proc (stream-car s))
      (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x)
  (newline)
  (display x))


(define (stream-enumerate low high)
  (if (> low high)
    the-empty-stream
    (cons-stream low
                 (stream-enumerate (+ low 1) high))))

(define (stream-filter pred s)
  ;(display-line (pred (stream-car s)))
  (if (stream-null? s)
    the-empty-stream
    (if (pred (stream-car s))
      (cons-stream (stream-car s)
                   (stream-filter pred (stream-cdr s)))
      (stream-filter pred (stream-cdr s)))))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
    the-empty-stream
    (cons-stream
      (apply proc (map stream-car argstreams))
      (apply stream-map (cons proc
                              (map stream-cdr argstreams))))))


;  无穷流

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
;  从 1 开始的自然数
(define integers (integers-starting-from 1))

(define (divisiable? x y) (= (remainder x y) 0))
;   不能被 7 整除的整数流
(define no-sevens
  (stream-filter (lambda (x) (not (divisiable? x 7)))
                 integers))

;   斐波那契数
(define (fibgen a b)
  (cons-stream a (fibgen b (+ a b ))))
(define fibs (fibgen 0 1))


(define (sieve stream)
  (cons-stream (stream-car stream)
               (stream-filter (lambda (x) 
                                (not (divisiable? x (stream-car stream))))
                              (stream-cdr stream))))
(define primes (sieve (integers-starting-from 2)))

;  隐式定义无穷流

(define ones (cons-stream 1 ones))
(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define integers2 (cons-stream 1 (add-streams ones integers2)))
;  有种错位相减的感觉，用前面一位，生产后面一位
(define fibs2
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs2)
                                         fibs2))))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

; double 为 2 的各个幂的序列：1，2，4，8，16，32.......
(define double (cons-stream 1 (scale-stream double 2)))

(define primes
  (cons-stream 2
               (stream-filter prime? (integers-starting-from 3))))
(define (prime? n)
  (define (iter ps)
    (cond 
      ((> (square (stream-car ps)) n) true)
      ((divisiable? n (stream-car ps)) false)
      (else (iter (stream-cdr ps)))))
  (iter primes))
; 这里的 primes 为递归定义，primes 中使用了 prime? ，而 prime? 中又使用了 primes
; 这一过程能行的原因是，在计算中的任一点，流 primes 都已经生成出足够多的部分，足以满足我们检查下面的任何数是否为素数；

; 序对的无穷流
(define (interleave s t)
  (if (stream-null? s)
    t
    (cons-stream (stream-car s)
                 (interleave t (stream-cdr s)))))



;  辅助过程，用于展示一个 stream 中的元素
(define (range first last)
  (if (>= first last)
      '()
      (cons first (range (+ first 1) last))))

(define (display-blank x)
  (display x)
  (display "  "))

(define (display-top10 s)
  (newline)
  (for-each (lambda (x) (display-blank (stream-ref s x))) (range 0 10))
  (newline))

(define (display-top10-line s)
  (newline)
  (for-each (lambda (x) (display-line (stream-ref s x))) (range 0 10)))
