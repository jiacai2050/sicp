(define (element-of-set? e set)
  (cond
    ((or (null? set) (> (car set) e)) #f)
    ((= (car set) e) #t)
    (else 
      (element-of-set? e (cdr set)))))

(element-of-set? 4 '(1 3 4 5 6))

(define (adjoin-set a set)
  (cond
    ((null? set) (cons a set))
    ((= (car set) a) set)
    ((> (car set) a)
      (cons a set))
    (else 
      (cons (car set)
        (adjoin-set a (cdr set))))))

(adjoin-set 4 '(1 3 5 6))
;Value: (1 3 4 5 6)

; 如果用有序的列表来表示集合，时间复杂度在最坏的情况下和无序的方式是一样的
; 但是平均时间是无序时的一半
