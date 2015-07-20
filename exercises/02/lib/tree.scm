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