; a)
(define (expt b n)
  (if (= n 0)
    1
    (* b (expt b (- n 1)))))

(controller
  (assign continue (label expt-done))
expt-loop
  (test (op =) (reg n) (const 0))
  (branch base-case)
  (save continue)
  (save n)
  (assign n (op -) (reg n) (const 1))
  (assign continue (label after-expt))
  (goto (label expt-loop))
after-expt
  (restore n)
  (restore continue)
  (assign val (op *) (reg n) (reg val))
  (goto (reg continue))
base-case
  (assign val (const 1))
  (goto (reg continue))
expt-done)

; b)

(define (expt b n)
  (define (expt-iter counter product)
    (if (= counter 0)
      product
      (expt-iter (- counter 1) (* b counter))))
  (expt-iter n 1))

(controller
  (assign continue (label expt-done))
expt-loop
  (test (op =) (reg counter) (const 0))
  (branch expt-done)
  (assign product (op *) (reg product) (reg counter))
  (assign counter (op -) (reg counter) (const 1))
  (goto (label expt-loop))
expt-done
  (assign val (reg product)))
