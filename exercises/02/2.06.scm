; 这个题目比较有意思，也算是让我们大开眼界了
; 关于邱奇数的系统介绍可以参考我的博客文章《编程语言的基石——Lambda calculus》
; http://liujiacai.net/blog/2014/10/12/lambda-calculus-introduction/


(define zero 
  (lambda (f) 
    (lambda (x) x)))

(define (add-1 n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))

(define one
  (lambda (f)
    (lambda (x)
      (f x))))

(define two
  (lambda (f)
    (lambda (x)
      (f (f x)))))

(define (add m n)
  (lambda (f)
    (lambda (x)
      ((m f) ((n f) x)))))