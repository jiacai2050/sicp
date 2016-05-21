 ;; add a test to make-operation-exp
 (define (make-operation-exp expr machine labels operations)
  (let ((op (lookup-prim (operation-exp-op expr) operations)) 
            (aprocs
                 (map (lambda (e)
                           (if (label-exp? e)
                               (error "can't operate on label -- MAKE-OPERATION-EXP" e)
                               (make-primitive-exp e machine labels)))
                      (operation-exp-operands expr))))
   (lambda ()
           (apply op (map (lambda (p) (p)) aprocs)))))
