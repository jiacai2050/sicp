(list 'a 'b)
; (a b)

(list (list 'geroge))
;((geroge))

(cdr '((x1 x2) (y1 y2)))
;((y1 y2))

(cadr '((x1 x2) (y1 y2)))
;(y1 y2)

(pair? (car '(a short list)))
; #f

(define (memq a lat)
  (if (null? lat)
    #f
    (or (eq? a (car lat))
        (memq a (cdr lat)))))

(memq 'red '((red shoes) (blue socks)))
;#f

(memq 'red '(red shoes blue socks))
;#t