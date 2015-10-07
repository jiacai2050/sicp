(define nil '())
(define already-seen '())
(define (seen? x)
  (define (iter already-seen)
    (if (null? already-seen)
      #f
      (or (eq? x (car already-seen))
          (iter (cdr already-seen)))))
  (iter already-seen))

(define (count-pairs x)
  (if (not (pair? x))
    0
    (if (seen? x) 0
      (begin
        (set! already-seen (cons x already-seen))
        (+ (count-pairs (car x))
           (count-pairs (cdr x))
           1)))))

(define p1 (cons 'a nil))
(define p2 (cons p1 nil))
(define p3 (cons p1 p2))
(count-pairs p3)
;Value: 3

(define p3 (cons 'a nil))
(define p2 (cons p3 nil))
(define p1 (cons p2 p3))
(count-pairs p1)
;Value: 3  在3.16题中返回4

(define p3 (cons 'a nil))
(define p2 (cons p3 p3))
(define p1 (cons p2 p2))
(count-pairs p1)
;Value: 3  在3.16题中返回7

(define p3 (cons 'c nil))
(define p2 (cons 'b p3))
(define p1 (cons 'a p2))
(set-cdr! (cddr p1) p1)
(count-pairs p1)
;Value: 3  在3.16题中为死循环

; 这题的思路比较简单，就是把已经count过的放到一个表，下次在count时，先去这个表看看是否存在，直接访问`car`与`cdr`部分即可。