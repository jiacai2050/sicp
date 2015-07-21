(load "lib/list.scm")
;2.17
(define (last-pair l)
  (if (null? (cdr l))
    (car l)
    (last-pair (cdr l))))
(last-pair (list 1 2 3 4 5 6 7 8))
;Value: 8 

;2.18
(define (reverse l)
  (if (null? l)
    nil
    (append (reverse (cdr l)) (list (car l)))))

(reverse (list 1 2 3 4 5 6 7 8))
;Value: (8 7 6 5 4 3 2 1)