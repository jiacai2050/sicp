(define (equal? seq1 seq2)
  (cond
    ((and (null? seq1) (null? seq2)) #t)
    ((or (null? seq1) (null? seq2)) #f)
    (else (and
            (eq? (car seq1) (car seq2))
            (equal? (cdr seq1) (cdr seq2))))))

(equal? '(apple orange banana) '(apple orange banana))
;#t
(equal? '(apple orange banana) '(apple orange (banana)))
;#f
(equal? '(apple orange banana) '(apple orange banana pear))
;#f
(equal? '(apple orange banana pear) '(apple orange banana))
;#f