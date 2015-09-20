; 稠密多项式
(define (install-dense-package)
  (define (adjoin-term term term-list)
    (if (emtpy-termlist? term-list)
      term
      (list term term-list)))
  (define the-empty-termlist '())
  (define (first-term term-list) 
    (make-term-for-dense (car term-list) (length term-list)))
  (define (rest-term term-list) (cdr term-list))
  (define (emtpy-termlist? term-list)
    (null? term-list))
  (define (make-term-for-dense order coeff)
    (define (iter order)
      (if (= 0 order)
        '(0)
        (cons 0 (iter (- order 1)))))
    (cons coeff (iter (- order 1))))
  (define (order term)
    (+ 1 (length term)))
  (define (coeff term)
    (car term))
  (define (add-terms L1 L2)
    (cond 
      ((empty-termlist? L1) L2)
      ((empty-termlist? L2) L1)
      (else 
        (let ((t1 (length L1))
              (t2 (length L2)))
          (let ((diff (- t1 t2)))
            (cond
              ((= 0 diff) 
                (cons (add (car L1) (car L2))
                      (add-terms (cdr L1) (cdr L2))))
              ((> 0 diff)  ; t2 阶数高
                (cons (car L2)
                      (add-terms L1 (cdr L2))))
              (else
                (cons (car L1)
                      (add-terms (cdr L1) L2)))))))))
  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
      (the-empty-termlist)
      (let ((rests (rest-terms L1)))
        (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms rests L2)))))

  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L)))
        (adjoin-term
          (make-term (+ (order t1) (order t2))
                     ;这里用了通用型的mul把系数乘起来，原因同上
                     (mul (coeff t1) (coeff t2)))
          (mul-term-by-all-terms t1 (rest-terms L))))))

  ; 外部接口
  (define (tag t) (cons 'dense t))
  (put 'adjoin-term 'dense
    (lambda (term term-list) (tag (adjoin-term term term-list))))
  (put 'make-term-for-dense 'dense
    (lambda (order coeff) (tag (make-term-for-dense order coeff))))
  (put 'add-terms 'dense
    (lambda (L1 L2) (tag (add-terms L1 L2))))
  (put 'mul-terms 'dense
    (lambda (L1 L2) (tag (mul-terms L1 L2))))
  'done)

; 稀疏多项式
(define (install-sparse-package)
  ;内部实现
  (define (adjoin-term term term-list)
    (if (=zero? (coff term))
      term-list
      (cons term term-list)))
  (define (the-empty-termlist) '())
  (define (first-term term-list)
    (car term-list))
  (define (rest-term term-list)
    (cdr term-list))
  (define (empty-termlist? term-list)
    (null? term-list))
  (define (make-term-for-sparse order coeff)
    (list order coeff))
  (define (order term)
    (car term))
  (define (coeff term)
    (cadr term))

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

  ; 外部接口
  (define (tag t) (attch-tag 'sparse t))
  (put 'adjoin-term 'sparse
    (lambda (term term-list) (tag (adjoin-term term term-list))))
  (put 'add-terms 'sparse
    (lambda (L1 L2) (tag (add-terms L1 L2))))
  (put 'mul-terms 'sparse
    (lambda (L1 L2) (tag (mul-terms L1 L2))))
  (put 'make-term 'sparse
    (lambda (order coeff) (tag (make-term-for-sparse order coeff))))
  'done)
