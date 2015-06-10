
(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

(gcd 206 40)
; 正则序，全部展开，最后规约
(if (= 40 0)
    206
    (gcd 40 (remainder 206 40)))
; if的结果为
(gcd 40 (remainder 206 40)
;------------------------------------------->>>>
(if (= (remainder 206 40) 0)
    40
    (gcd (remainder 206 40) 
         (remainder 40 (remainder 206 40))))
;这里if谓词执行，调用一次remainder后的结果为:
(gcd (remainder 206 40) 
     (remainder 40 (remainder 206 40)))
;------------------------------------------->>>>
(if (= (remainder 40 (remainder 206 40)) 0) ;(= 4 0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))))
;这里if谓词执行， 调用两次remainder后，结果为
(gcd (remainder 40 (remainder 206 40))
     (remainder (remainder 206 40)
                (remainder 40 (remainder 206 40))))
;------------------------------------------->>>>
(if (= (remainder (remainder 206 40)
                  (remainder 40 (remainder 206 40)))
       0)
    (remainder 40 (remainder 206 40))
    (gcd (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))
         (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))))

; 正则序太麻烦了，我这里先展开到这里，困了后面再补上。

; 应用序，先求参数，后代入
(gcd 40 6) ;一次
(gcd 6 4)  ;一次
(gcd 4 2)  ;一次 
(gcd 2 0)  ;一次
2          
;一共调用了4次
