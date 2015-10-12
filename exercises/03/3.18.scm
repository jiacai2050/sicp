(define nil '())
(define already-seen '())
(define (seen? x)
  (define (iter already-seen)
    (if (null? already-seen)
      #f
      (or (eq? x (car already-seen))
          (iter (cdr already-seen)))))
  (iter already-seen))

(define (hasCircle? x)
  (if (pair? x)
    (if (seen? x)
      #t
      (begin
        (set! already-seen (cons x already-seen))
        (or (hasCircle? (car x))
            (hasCircle? (cdr x)))))
    #f))

(define aa '(a b c))
(hasCircle? aa)
;Value: #f

(define p3 (cons 'c nil))
(define p2 (cons 'b p3))
(define p1 (cons 'a p2))
(set-cdr! (cddr p1) p1)

(hasCircle? p1)
;Value: #t