(load "lib/list.scm")

(define (same-parity flag . others)
  (define (iter is_even l)
    (cond
      ((null? l) nil)
      ((even? (car l))
        (if is_even
          (cons (car l) (iter is_even (cdr l)))
          (iter is_even (cdr l))))
      (else
        (if is_even
          (iter is_even (cdr l))
          (cons (car l) (iter is_even (cdr l)))))))
  (let ((is_even (even? flag)))
    (display is_even)
    (cons flag (iter is_even others))))

(same-parity 1 2 3 4 5 6 7)
;Value: (1 3 5 7)
(same-parity 2 3 4 5 6 7)
;Value: (2 4 6)