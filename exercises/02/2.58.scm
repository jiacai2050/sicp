(load "lib/deriv.scm")

; a)
(define (make-sum a1 a2)
  (cond
    ((=number? a1 0) a2)
    ((=number? a2 0) a1)
    ((and (number? a1) (number? a2)) (+ a1 a2))
    (else (list a1 '+ a2))))
(define (make-product m1 m2)
  (cond
    ((or (=number? m1 0) (=number? m2 0)) 0)
    ((=number? m1 1) m2)
    ((=number? m2 1) m1)
    ((and (number? m1) (number? m2)) (* m1 m2))
    (else (list m1 '* m2))))
(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))
(define (addend s) (car s))  
(define (augend s) (caddr s))
(define (product? x)
  (and (pair? x) (eq? (cdar x) '*)))
(define (multiplier p) (car p))  
(define (multiplicand p) (caddr p))

(augend '(a + b))
(sum? '(a + b))

(deriv '(x + (y + x)) 'x)
;Value: (1 + (0 + 1))
;可以看到这里只是改变了构造函数与选择函数的实现，就可以支持中缀表达式

; b)
; 这里简单分析下，在a中我们已经知道了在有括号的情况下，可以算多个参数的情况了
; 那么我们这里只需要把省略的括号加上就可以了。思路是这样，下面分析下如何加括号
; 主要是乘法的优先级比加法的要高，所以要把所有乘法的运算加上括号，例如
; 3 * 5 + 2 * 2
; 我们要把 3*5 与 2*2 看作一个整体
; 我这里的思路也很直接，如果exp中有＋，那么 (sum? exp) 返回true，同时把加号两边的表达式作为addend与augend

(define (operation expr) 
 (if (memq '+ expr) 
     '+ 
     '*)) 

(define (sum? expr) 
  (eq? '+ (operation expr))) 
(define (addend expr) 
  (define (iter expr result) 
    (if (eq? (car expr) '+) 
      result 
      (iter (cdr expr) (append result (list (car expr))))))
  (let ((result (iter expr '())))
    (if (= (length result) 1) 
      (car result) 
      result))) 
(define (augend expr) 
  (let ((result (cdr (memq '+ expr)))) 
    (if (= (length result) 1) 
      (car result) 
      result)))

(define (product? expr) 
  (eq? '* (operation expr))) 
; (define (multiplier expr) 
;   (define (iter expr result) 
;     (if (eq? (car expr) '*) 
;       result 
;       (iter (cdr expr) (append result (list (car expr))))))
;   (let ((result (iter expr '()))) 
;     (if (= (length result) 1) 
;       (car result) 
;       result)))

; (define (multiplicand expr) 
;   (let ((result (cdr (memq '* expr)))) 
;     (if (= (length result) 1) 
;       (car result) 
;       result)))

;---------更新：2015/12/13---------------------------------
; 之前实现的 multiplier 与 multiplicand 过于复杂了，可以做如下的简化
; 感谢 https://github.com/jke-zq 的提醒
(define (multiplier expr) 
  (car expr))
(define (multiplicand expr)
  (if (= 1 (length expr))
    (car expr)
    (cddr expr)))

(deriv '(a * b * c + d * e * f + a + a * m + z) 'a)
;Value: ((b * c) + (1 + (m)))

; 虽说思路是有了，但是写出来又是另一回事了，我这里的代码参考了下面的链接
; http://community.schemewiki.org/?sicp-ex-2.58