;Huffman树的表示
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? obj)
  (eq? 'leaf (car obj)))

(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) 
  (car tree))
(define (right-branch tree) 
  (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
    (list (symbol-leaf tree))
    (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
    (weight-leaf tree)
    (cadddr tree)))

;解码过程
(define (decode bits tree)
  (define (decode-iter bits current-branch)
    (if (null? bits)
      '()
      (let ((next-branch (choose-branch (car bits) current-branch)))
        (if (leaf? next-branch)
          (cons (symbol-leaf next-branch)
                (decode-iter (cdr bits) tree))
          (decode-iter (cdr bits) next-branch)))))
  (decode-iter bits tree))

(define (choose-branch bit tree)
  (cond
    ((= 0 bit) (left-branch tree))
    ((= 1 bit) (right-branch tree))
    (else
      (error "bad bit --- CHOOSE_BRANCH" bit))))

;带权重元素的集合
(define (adjoin-set x set)
  (cond
    ((null? set) (list x))
    ((< (weight x) (weight (car set)))
      (cons x set))
    (else
      (cons (car set)
            (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
    '()
    (let ((pair (car pairs)))
      (adjoin-set (make-leaf (car pair) ;symbol
                             (cadr pair)) ;frequency
                  (make-leaf-set (cdr pairs))))))


