;2.21
(define (square-list items)
  (if (null? items)
    nil
    (cons (square (car items))
          (square-list (cdr items)))))

(load "lib/list.scm")
(define (square-list2 items)
  (map square items))

;2.22
(define 1-4 (list 1 2 3 4))
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons (square (car things))
                  answer))))
  (iter items nil))

;按照上面这种方式，从前向后逐次把items中的元素，平方后插入到answer中，所有结果是反向的。
(square-list 1-4)
;Value: (16 9 4 1)
;如果直接交换cons的两个参数，会得到嵌套list的形式
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons answer
                  (square (car things))))))
  (iter items nil))
(square-list 1-4)
;Value: ((((() . 1) . 4) . 9) . 16)
;如何想要迭代实现这题，需要借助之前append函数
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (append answer
                  (list (square (car things)))))))
  (iter items nil))
(square-list 1-4)
;Value: (1 4 9 16)

;2.23
(define (for-each proc items)
  (if (null? items)
    #t
    (begin (proc (car items))
           (for-each proc (cdr items)))))