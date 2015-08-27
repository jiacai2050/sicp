(define (look-up given-key tree)
  (cond
    ((null? tree) #f)
    ((= given-key (car tree)) #t)
    ((> given-key (car tree))
      (look-up given-key (right-branch tree)))
    (else
      (look-up given-key (left-branch tree)))))