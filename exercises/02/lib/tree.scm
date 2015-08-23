(define (scale-tree tree factor)
  (cond 
    ((null? tree) nil)
    ((not (pair? (car tree)))
      (* (car tree) factor))
    (else
      (cons (scale-tree (car factor))
            (scale-tree (cdr factor))))))

(define (scale-tree2 tree factor)
  (map
    (lambda(subtree)
      (if (pair? subtree)
        (scale-tree2 subtree factor)
        (* subtree factor)))
    tree))

(define (make-tree entry left right)
  (list entry left right))
(define (entry tree)
  (car tree))
(define (left-branch tree)
  (cadr tree))
(define (right-branch tree)
  (caddr tree))

(define (element-of-set? x set)
  (cond
    ((null? set) #f)
    ((= x (entry set)) #t)
    ((< x (entry set))
      (element-of-set? x (left-branch set)))
    (else
      (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond
    ((null? set) (make-tree x '() '()))
    ((= x (entry set)) set)
    ((< x (entry set)) 
      (make-tree (entry) 
                 (adjoin-set x (left-branch set))
                 (right-branch set)))
    (else
      (make-tree (entry) 
                 (left-branch set)
                 (adjoin-set x (right-branch set))))))
