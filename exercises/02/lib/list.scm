(define (length l)
  (if (null? l)
    0
    (+ 1 (length (cdr l)))))

(define (append list1 list2)
  (if (null? list1)
    list2
    (cons (car list1) (append (cdr list1) list2))))

;http://stackoverflow.com/questions/9115703/null-value-in-mit-scheme
(define nil '())

(define (map proc l)
  (if (null? l)
    nil
    (cons (proc (car l)) 
          (map proc (cdr l)))))

(define (scale-list l factor)
  (map (lambda (x) (* x factor))
       l))

(define (count-leaves x)
  (cond
    ((null? x) 0)
    ((not (pair? x)) 1)
    (else 
      (+ (count-leaves (car x))
         (count-leaves (cdr x))))))