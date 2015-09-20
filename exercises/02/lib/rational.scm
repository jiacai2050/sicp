; 2.1.1 有理数算术包
(define (make-rat n d)
  (let ((g (gcn n d)))
    (cons (/ n g) (/ d g))))

(define (numer x) (car x))
(define (demon x) (cdr x))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (demon y))
               (* (demon x) (numer y)))
            (* (demon x) (demon y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (demon y))
               (* (demon x) (numer y)))
            (* (demon x) (demon y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (demon y))
            (* (demon x) (numer y))))

(define (div-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (demon x) (demon y))))

(define (equal-rat? x y)
  (= (* (numer x) (numer y))
     (* (demon x) (demon y))))
