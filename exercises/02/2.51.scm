(define (below p1 p2)
  (let ((split-point (make-vect 0 0.5)))
    (let ((paint-top
            (transform-painter p2
                               split-point
                               (make-vect 1 0.5)
                               (make-vect 1 0))))
          (paint-bottom
            (transform-painter p1
                               (make-vect 0 0)
                               (make-vect 1 0)
                               split-point)))
      (lambda (frame)
        (paint-top frame)
        (paint-bottom frame))))


(define (below p1 p2)
  (rotate90 (beside p1 p1)))