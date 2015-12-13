(load "lib/stream.scm")
; a)
(define (div-streams s1 s2)
  (stream-map / s1 s2))
(define (integrate-series s)
  (div-streams s integers))

(define foo (integrate-series double))

(display-top10 foo)
; 1  1  4/3  2  16/5  16/3  64/7  16  256/9  256/5

; b)

; e的x次方的导数还是e的x次方，这也就是说e的x次方与e的x次方的积分是同一个级数
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(display-top10 exp-series)
; 1  1  1/2  1/6  1/24  1/120  1/720  1/5040  1/40320  1/362880

; sin 的导数为cos，这也就是说 cos 的积分与sin 是同一个级数
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

; cons 的导数为负的sin，这也就是说，-sin 的积分与 cons 是同一个级数
(define cosine-series
  (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(display-top10 sine-series)
; 0  1  0  -1/6  0  1/120  0  -1/5040  0  1/362880
(display-top10 cosine-series)
; 1  0  -1/2  0  1/24  0  -1/720  0  1/40320  0



;  这个题起初看上去挺难的，起始慢慢读题目，发现和我们之前高考时，最后的数学大题一样，给你一个新的概念，然后让你基于这个概念来做题。
;  这个题没什么难度，不过上面再求 sine-series 与 cosine-series 时，它们之间相互递归调用，这一点需要注意