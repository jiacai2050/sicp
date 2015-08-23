(define (element-of-set? e set)
  (if (null? set)
    false
    (or (eq? e (car set))
        (element-of-set? e (cdr set)))))

(define (union-set set1 set2)
  (cond
    ((null? set1) set2)
    ((element-of-set? (car set1) set2)
      (union-set (cdr set1) set2))
    (else
      (union-set (cdr set1) (cons (car set1) set2)))))

(union-set '(a b c) '(a b d))
;Value: (c a b d)