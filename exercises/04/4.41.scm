(define nil '())
(define (accumulate initial-value op seqs)
  (if (null? seqs)
    initial-value
    (op (car seqs)
        (accumulate initial-value op (cdr seqs)))))
(define (flatmap proc seqs)
  (accumulate nil append (map proc seqs)))

(define (caddddr x)
    (car (cdr (cdr (cdr (cdr x))))))

(define (distinct? seq)
  (cond
    ((null? seq) #t)
    ((null? (cdr seq)) #t)
    ((member (car seq) (cdr seq)) #f)
    (else (distinct? (cdr seq)))))

(define (multiple-dwelling)
  (filter (lambda (others)
            (let ((smith-level (caddddr others))
                  (fletcher-level (caddr others))
                  (cooper-level (cadr others)))
              (and (distinct? others)
                   (not (= (abs (- smith-level fletcher-level)) 1))
                   (not (= (abs (- fletcher-level cooper-level)) 1)))))
    (flatmap (lambda (others)
               (map (lambda (smith-level) (append others (list smith-level)))
                    '(1 2 3 4 5)))
      (filter (lambda (others)
                (let ((miller-level (cadddr others))
                      (cooper-level (cadr others)))
                  (> miller-level cooper-level)))
        (flatmap (lambda (others)
                   (map (lambda (miller-level) (append others (list miller-level)))
                        '(1 2 3 4 5)))
          (flatmap (lambda (others)
                     (map (lambda (fletcher-level) (append others (list fletcher-level)))
                          '(2 3 4)))
            (flatmap (lambda (baker-level)
                   (map (lambda (cooper-level) (list baker-level cooper-level))
                        '(2 3 4 5)))
              '(1 2 3 4))))))))

(multiple-dwelling)
;Value: ((3 2 4 5 1))

;另一种方式是生成所有楼层的排列组合，然后再 filter 即可，这本书的作者想要的写法应该是这种，但是这种效率比我上面这种应该会更低。仅供参考：
;https://wizardbook.wordpress.com/2011/01/12/exercise-4-41/
;http://community.schemewiki.org/?sicp-ex-4.41
