;题目给出了下面的构造函数
(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

;下面依次回答问题
; a)
(define left-branch car)
(define right-branch cadr)
(define branch-length car)
(define branch-structure cadr)

; b)
(define (total-weight m)
  (let ((lb (left-branch m))
        (rb (right-branch m)))
    (cond
      ((and (pair? (branch-structure lb)) (pair? (branch-structure rb)))
        (+ (total-wight (branch-structure lb))
           (total-wight (branch-structure rb))))
      ((and (pair? (branch-structure lb)) (not (pair? (branch-structure rb))))
        (+ (total-wight (branch-structure lb))
           (branch-structure rb)))
      ((and (not (pair? (branch-structure lb))) (pair? (branch-structure rb)))
        (+ (total-wight (branch-structure rb))
           (branch-structure lb)))
      (else
        (+ (branch-structure lb)
           (branch-structure rb))))))

; c)
; 解这个题需要用到相互递归
(define (branch-weight branch)
   (if (pair? (branch-structure branch))
       (total-weight (branch-structure branch))
       (branch-structure branch)))

(define (branch-torque branch)
  (* (branch-length branch)
     (branch-weight branch)))

(define (branch-balance? branch)
  (if (pair? (branch-structure branch))
    (balance? (branch-structure branch))
    #t))

(define (balance? mobile)
  (and (= (branch-torque (left-branch mobile))
          (branch-torque (right-branch mobile)))
       (branch-balance? (left-branch mobile))
       (branch-balance? (right-branch mobile))))

;我们可以试两个简单的例子
(define a (make-mobile (make-branch 2 3) (make-branch 2 3)))
(define b (make-mobile (make-branch 2 3) (make-branch 4 5)))
(total-weight a)
;Value: 6
(total-weight b)
;Value: 8
;创建个复杂的例子
(define c (make-mobile (make-branch 5 a) (make-branch 3 b)))
(total-weight c)
;Value: 14
(balance? c)
; 举一个平衡的例子
(define d (make-mobile (make-branch 10 a) (make-branch 12 5)))
(balance? d)

; d) 如果修改了构造方式，我们只需要修改我们的选择函数即可
;新的构造函数
(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))
;新的选择函数
(define left-branch car);保持不变
(define right-branch cdr)
(define branch-length car );保持不变
(define branch-structure cdr)


;我一次解答 c) 写错了，想的比较简单，现在贴在下面，备忘：
(define (balance? m)
  (let ((lb (left-branch m))
        (rb (right-branch m)))
    (cond
      ((and (pair? (branch-structure lb)) (pair? (branch-structure rb)))
        (and (balance? (branch-structure lb))
             (balance? (branch-structure rb))))
      ((and (not (pair? (branch-structure lb))) (not (pair? (branch-structure rb))))
        (= (* (branch-length lb) (branch-structure lb))
           (* (branch-length rb) (branch-structure rb))))
      (else #f))))
;参考：http://www.billthelizard.com/2011/02/sicp-229-binary-mobiles.html