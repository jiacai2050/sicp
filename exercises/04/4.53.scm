(let ((pairs '()))
  (if-fail (let ((p (prime-sum-pair '(1 3 5 8) '(20 35 100))))
             (permanent-set! pairs (cons p pairs))
             (amb))
           pairs))

; 最终的结果即为所有的 prime-sum 序对
; ((8 35) (3 110) (3 20))
