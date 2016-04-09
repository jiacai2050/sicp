(define (my-append x y)
  (if (null? x)
    y
    (cons (car x) (my-append (cdr x) y))))

(define x '(a b c))
(define y '(d e f))
(my-append  x y)   
