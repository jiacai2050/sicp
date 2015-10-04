; 取款生成器

(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds.")))

(define W1 (make-withdraw 100))
(W1 60)
; 40
(W1 60)
; "Insufficient funds."

; 银行账户对象

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond 
      ((eq? m 'withdraw) withdraw)
      ((eq? m 'deposit) deposit)
      (else (error "Unknown request == MAKE-ACCOUNT" m))))
  dispatch)

(define acc (make-account 100))
((acc 'withdraw) 50)
;Value: 50
((acc 'withdraw) 60)
;Value: "Insufficient funds"
((acc 'deposit) 40)
;Value: 90
((acc 'withdraw) 60)
;Value: 30