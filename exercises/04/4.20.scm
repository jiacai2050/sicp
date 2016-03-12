; a)

(define (letrec? exp)
  (tagged-list exp 'letrec))
(define (letrec-bindings exp)
  (cadr exp))
(define (letrec-binding-vars exp)
  (map car (letrec-bindings exp)))
(define (letrec-binding-vals exp)
  (map cadr (letrec-bindings exp)))
(define (letrec-body exp)
  (cddr exp))

(define (make-unassigned-bindings vars)
  (map (lambda (var) (cons var '*unassigned*)) vars))

(define (make-set-clauses vars vals)
  (map (lambda (var val) (list 'set! var val)) vars vals))


(define (letrec->let exp)
  (let ((vars (letrec-binding-vars exp))
        (vals (letrec-binding-vals exp)))
    (make-let (make-unassigned-bindings vars)
              (append (make-set-clauses vars vals)
                      (letrec-body exp)))))

; b)

;let 就相当于是一次过程应用，展现形式如下：

((lambda (even? odd?)
   <rest of body of f>)
  (lambda (n) <body of even? including call to odd?>)
  (lambda (n) <body of odd? including call to even?>))

;这里 lambda 中的两个参数 even? odd? 的名字是可以随意更改的，但是在下面的两个 lambda 参数中，even? odd? 是预先定义好的，无法修改，所以这时会有错误。
