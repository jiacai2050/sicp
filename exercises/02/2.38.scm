(load "lib/list.scm")
(load "2.37.scm")

(define (fold-right op initial sequence)
  (accumulate op initial sequence))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))

(fold-left / 1 (list 1 2 3))
;Value: 1/6
(fold-right / 1 (list 1 2 3))
;Value: 3/2
(fold-left list nil (list 1 2 3))
;Value: (((() 1) 2) 3)
(fold-right list nil (list 1 2 3))
;Value: (1 (2 (3 ())))


(define (test x y)
  ;满足交换，不满足结合
  (- (* x y)
     (+ x y)))

(fold-left test 1 (list 1 2 3))
;Value: -9
(fold-right test 1 (list 1 2 3))
;Value: -1

;矩阵相乘，满足结合率，不满足交换率
(define m1 (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))
(define m2 (list (list 11 12 13) (list 14 15 16) (list 17 18 19)))
(define m3 (list (list 21 22 23) (list 24 25 26) (list 27 28 29)))

(define E (list (list 1 1 1) (list 1 1 1) (list 1 1 1)))

(fold-left matrix-*-matrix E (list m1 m2 m3))
;Value: ((50166 52245 54324) (50166 52245 54324) (50166 52245 54324))
(fold-right matrix-*-matrix E (list m1 m2 m3))
;Value 23: ((21708 21708 21708) (52245 52245 52245) (82782 82782 82782))

;通过上面可以看出,对于相同的初始值，op如果只满足率或只满足结合率都是不够的，需要同时满足两者，像加法、乘法都可以

;更多参考：
;https://en.wikipedia.org/wiki/Commutative_non-associative_magmas
