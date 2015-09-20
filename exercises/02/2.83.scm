(define (install-scheme-number-package) 
  ;; ... 
  (put 'raise '(scheme-number) 
    (lambda (x) (make-rational x 1)))
  
  'done)

(define (install-rational-package) 
  ;; ... 
  (put 'raise '(rational) 
    (lambda (x) (make-real (/ (numer x) (denom x)))))

  'done) 

(define (install-real-package)   
  ;; ... 
  (put 'raise '(real) 
    (lambda (x) (make-from-real-imag x 0)))

  'done)
