(load "2.68.scm")
(load "2.69.scm")

(define huff
  (generate-huffman-tree 
    '((BOOM 1) (WAH 1) (A 2) (GET 2) (JOB 2) (SHA 3) (YIP 9) (NA 16))))

huff
;Value: ((leaf wah 1) ((leaf boom 1) ((leaf job 2) ((leaf get 2) ((leaf a 2) ((leaf sha 3) ((leaf yip 9) (leaf na 16) (yip na) 25) (sha yip na) 28) (a sha yip na) 30) (get a sha yip na) 32) (job get a sha yip na) 34) (boom job get a sha yip na) 35) (wah boom job get a sha yip na) 36)  

(encode '(Get a job) huff)
;Value: (1 1 1 0 1 1 1 1 0 1 1 0)

(encode '(sha na na na na) huff)
;Value: (1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)

; 后面的就不重复列举了
; 如果用定长编码这8个符号，那么需要3个二进制位，这首歌太长，我就不比较了，感兴趣的可以自己玩玩。