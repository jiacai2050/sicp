(load "lib/huffman.scm")

(define sample-tree
  (make-code-tree
    (make-leaf 'A 4)
    (make-code-tree 
      (make-leaf 'B 2)
      (make-code-tree
        (make-leaf 'D 1)
        (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

sample-tree
;Value 13: ((leaf a 4) ((leaf b 2) ((leaf d 1) (leaf c 1) (d c) 2) (b d c) 4) (a b d c) 8)
;格式化后为下面的样子
; ((leaf a 4) 
;  ((leaf b 2) 
;   ((leaf d 1) 
;    (leaf c 1)
;    (d c) 2) 
;   (b d c) 4) 
;  (a b d c) 8)

(decode sample-message sample-tree)
;Value: (a d a b b c a)