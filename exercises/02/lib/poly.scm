(define (add-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (make-poly (variable p1)
               (add-terms (term-list p1) (term-list p2)))
    (error "Polys not in same var: ADD-POLY " (list p1 p2))))

(define (mul-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (make-poly (variable p1)
               (mul-terms (term-list p1) (term-list p2)))
    (error "Polys not in same var: MUL-POLY " (list p1 p2))))

(define (install-polynomial-package)
  ;; internal procedures
  ;; representation of poly
  (define (make-poly variable term-list)
    (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  ;2.3.2小节的 variable? 与 same-variable?
  (define (variable? x ) (symbol? x))
  (define (same-variable? x y)
    (and (variable? x) (variable? y) (eq? x y)))

  ;representation of terms and term lists
  ;(procedures adjoin-term ... coeff from text below)
  ;(define (add-poly p1 p2) )
  ;(define (mul-poly p1 p2) ...)

  ;interface to rest of system
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial)
    (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
    (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'make 'polynomial
    (lambda (var terms) (tag (make-poly var terms))))
  (put '=zero? 'polynomial 
    (lambda(poly) 
      (or (empty-termlist? (term-list poly))
          (= 0 (first-term (coeff (term-list poly)))))))
  'done)

;项表的构造通过有序的列表实现
;由于大多数多项式的项表是稀疏的，所以这里的项表用(order coeff)的形式表示。
;这里假设term的order总是高于term-list最左侧的
(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
    term-list
    (cons term term-list)))

(define (the-empty-termlist) '())

(define (first-term term-list)
  (car term-list))

(define (rest-term term-list)
  (cdr term-list))  

(define (empty-termlist? term-list)
  (null? term-list))

(define (make-term order coeff)
  (list order coeff))

(define (order term)
  (car term))

(define (coeff term)
  (cadr term))

(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))


(define (add-terms L1 L2)
  (cond 
    ((empty-termlist? L1) L2)
    ((empty-termlist? L2) L1)
    (else 
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (cond 
          ((> (order t1) (order t2)) 
            (adjoin-term t1 (add-terms (rest-term L1) L2)))
          ((< (order t1) (order t2)) 
            (adjoin-term t2 (add-terms L1 (rest-term L2))))
          (else
            (adjoin-term
              ;这里用了通用型的add把同阶的系数加起来
              ;由于add是通用的，所以我们多项式的系数可以是任意类型（通用算术程序包能够处理）
              (make-term (order t1) (add (coeff t1) (coeff t2)))  
              (add-terms (rest-term L1) (rest-term L2)))))))))

(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
    (the-empty-termlist)
    (add-terms (mul-term-by-all-terms (first-term L1) L2)
               (mul-terms (rest-terms L1) L2))))

(define (mul-term-by-all-terms t1 L)
  (if (empty-termlist? L)
    (the-empty-termlist)
    (let ((t2 (first-term L)))
      (adjoin-term
        (make-term (+ (order t1) (order t2))
                   ;这里用了通用型的mul把系数乘起来，原因同上
                   (mul (coeff t1) (coeff t2)))
        (mul-term-by-all-terms t1 (rest-terms L))))))
