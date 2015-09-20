(define (install-polynomial-package) 
  ;; ... 
  (put '=zero? 'polynomial 
    (lambda(poly) 
      (or (empty-termlist? (term-list poly))
          (= 0 (first-term (coeff (term-list poly)))))))
  'done)
