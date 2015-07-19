(load "lib/list.scm")
;2.17
(define (last-pair l)
  (if (null? (cdr l))
    (car l)
    (last-pair (cdr l))))
;2.18
(define (reverse l)
  (if (null? (cdr l))
    l
    (append (reverse (cdr l)) (list (car l)))))