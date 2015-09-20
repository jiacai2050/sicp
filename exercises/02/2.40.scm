(load "lib/list.scm")

(define (enumerate-interval n)
    (if (< n 1)
      nil
      (append (enumerate-interval (- n 1))
              (list n))))

(define (unique-pairs n)
  (accumulate append nil 
    (map
      (lambda (i)
        (map (lambda (j) (list j i))
          (enumerate-interval (- i 1))))
      (enumerate-interval n))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(unique-pairs 4)
;Value: ((1 2) (1 3) (2 3) (1 4) (2 4) (3 4))

(define (prime? n)
  (define (iter i)
    (if (< i n)
      (if (not (= 0 (remainder n i)))
        (iter (+ i 1))
        #f)
      #t))
  (iter 2))

(define (prime-sum-pairs n)
  (filter (lambda (p)
            (prime? (+ (car p) (cadr p))))
          (unique-pairs n)))

(prime-sum-pairs 6)
;Value: ((1 2) (2 3) (1 4) (3 4) (2 5) (1 6) (5 6))