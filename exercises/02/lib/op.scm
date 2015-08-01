(define nil '())
(define (filter predicate sequence)
  (cond 
    ((null? sequence) nil)
    ((predicate (car sequence))
      (cons (car sequence)
            (filter predicate (cdr sequence))))
    (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))
