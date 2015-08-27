(load "lib/huffman.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-sets)
  (if (= 1 (length leaf-sets))
    (car leaf-sets)
    (make-code-tree (car leaf-sets)
                    (successive-merge (cdr leaf-sets)))))

(generate-huffman-tree '((A 1) (B 2) (C 2) (D 4)))
;Value: ((leaf a 1) ((leaf c 2) ((leaf b 2) (leaf d 4) (b d) 6) (c b d) 8) (a c b d) 9)