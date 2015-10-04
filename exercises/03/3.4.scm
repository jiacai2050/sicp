(define (call-the-cops)
  (lambda (x)
    "The cops is called"))
(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit input-pwd amount)
    (set! balance (+ balance amount))
    balance)
  (define try 6)
  (define (dispatch input-pwd m)
    (if (eq? input-pwd password)
      (cond 
        ((eq? m 'withdraw) withdraw)
        ((eq? m 'deposit) deposit)
        (else (error "Unknown request == MAKE-ACCOUNT" m)))
      (if (= try 0)
        (call-the-cops)
        (begin (set! try (- try 1))
          (lambda (x) "Incorrect password")))))
    dispatch)

(define acc (make-account 100 'sicp))

(define (iter i)
  (if (< i 6)
    (begin
      ((acc 'haha 'withdraw) 50)
      (iter (+ i 1)))))
; 递归调用6次
(iter 0)
; 第7次调用
((acc 'haha 'withdraw) 50)
;Value: "The cops is called"