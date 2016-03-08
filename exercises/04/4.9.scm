; 下面首先给出一种 for 与 while 的语法

(for (variable start end)
   body)

(while (predicate variable)
  body)

; 下面给出与上面对应语法的 for 派生表达式

(define (for? exp)
  (tagged-list exp 'for))
(define (for-variable exp)
  (caadr exp))
(define (for-start exp)
  (cadadr exp))
(define (for-end exp)
  (caddadr exp))
(define (for-body exp)
  (cddr exp))

(define (expand-range start end proc)
  (cond
    ((< start end)
      (proc start)
      (expand-range (+ start 1) end proc))))

(define (for->combination exp)
  (expand-range (for-start)
                  (for-end)
                  (make-lambda (list var)
                               (for-body exp))))

; 下面给出与上面对应语法的 while 派生表达式

(while (predicate variable)
  body)

(define (while? exp)
  (tagged-list exp 'while))

(define (while-predicate exp)
  (caadr exp))

(define (while-variable exp)
  (cadadr exp))

(define (while-body exp)
  (cddr exp))

(define (expand-predicate predicate i body)
  (if (predicate i)
    (cons 'begin body)))

(define (while->combination exp)
  (expand-predicate
    (while-predicate exp)
    (while-variable exp)
    (while-body exp)))
