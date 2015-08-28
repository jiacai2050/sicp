;  本题分析见
;  https://github.com/jiacai2050/sicp/blob/master/08/2015-08-28_huffman.md

(load "lib/huffman.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (arrange tree leaf-sets)
  (cond
    ;第一次直接返回了tree，其实arrange应该返回个list，调了好久😂
    ((null? leaf-sets) (list tree))
    (else 
      (let ((tw (weight tree))
            (lw (weight (car leaf-sets))))
        (if (< tw lw)
          (cons tree leaf-sets)
          (cons (car leaf-sets)
                (arrange tree (cdr leaf-sets))))))))

(define (successive-merge leaf-sets)
  (if (= 1 (length leaf-sets))
    (car leaf-sets)
    (successive-merge 
      (arrange (make-code-tree (car leaf-sets) (cadr leaf-sets))
               (cddr leaf-sets)))))

(generate-huffman-tree '((A 1) (B 2) (C 2) (D 4)))
;Value: ((leaf d 4) ((leaf b 2) ((leaf a 1) (leaf c 2) (a c) 3) (b a c) 5) (d b a c) 9)
(generate-huffman-tree '((A 1) (B 1) (C 1) (D 1)))
;Value 14: (((leaf d 1) (leaf c 1) (d c) 2) ((leaf b 1) (leaf a 1) (b a) 2) (d c b a) 4)