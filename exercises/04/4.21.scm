; 这道题目讲的是 Y 算子。关于 Y 算子的更多内容可以参考我写的文章
; http://liujiacai.net/blog/2016/02/22/recursion-without-name/

; a)

((lambda (n)
  ((lambda (fact)
    (fact fact n))
   (lambda (ft k)
    (if (= 1 k)
      1
      (* k (ft ft (- k 1)))))))
 10)

;Value: 3628800

; b)

(define (f x)
  ((lambda (even? odd?)
    (even? even? odd? x))
    (lambda (ev? od? n)
      (if (= n 0) true (od? ev? od? (- n 1))))
    (lambda (ev? od? n)
      (if (= n 0) false (ev? ev? od? (- n 1))))))

(f 10)
