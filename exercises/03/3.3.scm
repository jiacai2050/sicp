(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit input-pwd amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch input-pwd m)
    (if (eq? input-pwd password)
      (cond 
        ((eq? m 'withdraw) withdraw)
        ((eq? m 'deposit) deposit)
        (else (error "Unknown request == MAKE-ACCOUNT" m)))
      (lambda (x) "Incorrect password")))
  dispatch)

(define acc (make-account 100 'sicp))
((acc 'haha 'withdraw) 50)
;Value: "Incorrect password"
((acc 'sicp 'withdraw) 150)
;Value: "Insufficient funds"

; 这个程序看似简单，但还是有两点需要注意
; 1. 在相比之前的银行账户系统，如果需要添加密码，只需要在 dispatch 处进行校验即可
; 2. 就是在密码不正确时，需要返回一个函数，而不是直接输出一个字符串，银行它后面还要调用具体金额