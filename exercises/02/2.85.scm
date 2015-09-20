 (define (install-scheme-number-package) 
  ;; ... 
  (put 'project 'scheme-number
    (lambda (x) (make-rational x 1)))
  
  'done)

(define (install-rational-package) 
  ;; ... 
  (put 'project 'rational
    (lambda (x) 
      (make-scheme (round (/ (numer x) (denom x))))))

  'done) 

(define (install-real-package)   
  ;; ... 
  (put 'project 'real
    (lambda (x) (round x)))

  'done)

(define (type-val t) 
  (cond
    ((eq? t 'scheme-number) 1)
    ((eq? t 'rational) 2)
    ((eq? t 'real) 3)
    ((eq? t 'complex) 4)
    (else (error "No such type" t))))

(define (raise-to-complex x)
  ;就是把x一直raise的complex为止，比较简单，这里忽略
  )
(define (equal? x y)
  (let ((raised-x (raise-to-complex x))
        (raised-y (raise-to-complex y)))
    (and (= (image-part raised-x) (image-part raised-y))
         (= (real-part raised-x) (real-part raised-y)))))


(define (drop x)
  (let ((lower-project (get 'project (type-tag x))))
    (if lower-project
      (let ((lower-x (lower-project x)))
        (if (equal? (raise lower-x) x)
          (drop lower-x)
          x))
      x)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (drop (apply proc (map contents args)))
        (if (= (length args) 2)
          (let ((type1 (car type-tags))
                (type2 (cdr type-tags))
                (a1 (car args))
                (a2 (cdr args)))
            (let ((diff (higher? type1 type2)))
              (cond 
                ((= 0 diff) (error "No method for these types" (list op type-tags)))
                ((> 0 diff) (drop (apply-generic op (raise a1) a2 )))
                (else (drop (apply-generic op a1 (raise a2)))))))
          (error "No method for these types" (list op type-tags)))))))
