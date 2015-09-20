(define (install-polynomial-package)
  ;; ...
  (define (sub-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (sub-terms (term-list p1) (term-list p2)))
      (error "Polys not in same var: SUB-POLY " (list p1 p2))))

  (put 'sub 'polynomial
    (lambda (p1 p2) (tag (sub-poly p1 p2))))
  'done)

(define (sub-terms L1 L2)
  (cond 
    ((empty-termlist? L1) L2)
    ((empty-termlist? L2) L1)
    (else 
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (cond 
          ((> (order t1) (order t2)) 
            (adjoin-term t1 (sub-terms (rest-term L1) L2)))
          ((< (order t1) (order t2)) 
            (adjoin-term t2 (sub-terms L1 (rest-term L2))))
          (else
            (adjoin-term
              ;这里用了通用型的sub把同阶的系数加起来
              ;由于sub是通用的，所以我们多项式的系数可以是任意类型（通用算术程序包能够处理）
              (make-term (order t1) (sub (coeff t1) (coeff t2)))  
              (sub-terms (rest-term L1) (rest-term L2)))))))))
