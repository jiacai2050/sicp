(load "2.17_2.18.scm")

(define (deep-reverse items)
  (cond
    ((null? (cdr items)) 
      (if (pair? (car items))
        (list (deep-reverse (car items)))
        items))
    ((not (pair? (car items))) 
      (append (deep-reverse (cdr items)) (list (car items))))
    (else 
      (append (deep-reverse (cdr items))
              (list (deep-reverse (car items)))))))

(define x (list (list 1 2) (list 3 4)))
;Value: ((1 2) (3 4))
(reverse x)
;Value: ((3 4) (1 2))
(deep-reverse x)
;Value: ((4 3) (2 1))

;我第一次写时，把cond的第一个条件给忘了，这里要记住，每一处返回一个具体值之前都要判断其是否为pair，如果是，继续递归。