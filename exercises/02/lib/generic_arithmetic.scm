;2.5 通用型操作的系统
;http://stackoverflow.com/a/19114031/2163429
(define *op-table* (make-hash-table))

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) #f))

(define (all_keys)
  (hash-table/key-list *op-table*))

; scheme-number

(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put '=zero? 'scheme-number
    (lambda(x) (= 0 x)))
  (put 'add '(scheme-number scheme-number)
    (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
    (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
    (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
    (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number
    (lambda (x) (tag x))))

; rational
(define (install-rational-package)
  ;内部过程
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
  ; 外部接口
  (define (tag x)
    (attach-tag 'rational x))
  (put '=zero? 'rational
    (lambda(x) (= 0 (numer x))))
  (put 'add '(rational rational)
    (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
    (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
    (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
    (lambda (x y) (tag (div-rat x y))))
  (put 'make 'rational 
    (lambda (n d) (tag (make-rat n d))))
  'done)

(define (install-complex-package)
  ; 从rectangualr与polar包中引入构造过程
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ; 内部过程
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))

  ; 与外部的接口
  (define (tag z) (attach-tag 'complex z))
  (put '=zero? 'complex 
    (lambda (z) (and (= 0 (real-part z)) (= (imag-part z) 0))))
  (put 'add '(complex complex)
    (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
    (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
    (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
    (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
    (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
    (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)