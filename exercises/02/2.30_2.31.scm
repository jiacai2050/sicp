;2.30
(define (square-tree tree)
  (cond
    ((null? tree) '())
    ((not (pair? (car tree)))
      (cons (square (car tree))
            (square-tree (cdr tree))))
    (else
      (cons (square-tree (car tree))
            (square-tree (cdr tree))))))

(define (square-tree2 tree)
  (map
    (lambda (subtree)
      (if (pair? subtree)
        (square-tree2 subtree)
        (square subtree)))
  tree))

(square-tree (list 11 (list 1 2) (list 3 4 (list 5 6))))
;Value: (121 (1 4) (9 16 (25 36)))
(square-tree2 (list 11 (list 1 2) (list 3 4 (list 5 6))))
;Value: (121 (1 4) (9 16 (25 36)))


;2.31
(define (tree-map proc tree)
  (map
      (lambda (subtree)
        (if (pair? subtree)
          (square-tree2 subtree)
          (proc subtree)))
    tree))
(define (square-tree3 tree)
  (tree-map square tree))
(square-tree3 (list 11 (list 1 2) (list 3 4 (list 5 6))))
;Value: (121 (1 4) (9 16 (25 36)))