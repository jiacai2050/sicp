(load "lib/list.scm")

(define (fringe tree)
  (cond
    ((null? (cdr tree)) 
      (if (pair? (car tree))
        (fringe (car tree))
        tree))
    ((not (pair? (car tree))) 
      (cons (car tree) (fringe (cdr tree))))
    (else 
      (append (fringe (car tree))
              (fringe (cdr tree))))))

(define x (list (list 1 2) (list 3 4)))

(fringe x)
;Value: (1 2 3 4)
(fringe (list x x))
;Value: (1 2 3 4 1 2 3 4)

;这个题让求树的根节点，其实也就是遍历一边整个list，可以借鉴习题2.27的思路