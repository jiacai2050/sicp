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
        ((eq? m 'is-valid?)
          (eq? password input-pwd))
        (else (error "Unknown request == MAKE-ACCOUNT" m)))
      (lambda (x) "Incorrect password")))
  dispatch)

(define tom (make-account 100 'tom))

(define (make-joint acc old-pwd new-pwd)
  (lambda (input-pwd m)
    (if (eq? input-pwd new-pwd)
      (acc old-pwd m)
      (lambda (x) "Incorrect new password"))))

(define jack (make-joint tom 'tom 'jack))
((jack 'jack 'withdraw) 30)
;Value: 70
((tom 'tom 'withdraw) 30)
;Value: 40



(define jack (make-joint tom 'tom123 'jack))
((jack 'jack 'withdraw) 123)
;Value: "Incorrect password"
((jack 'jack123 'withdraw) 123)
;Value: "Incorrect new password"