(load "2.38.scm")
(load "lib/list.scm")

(define (reverse sequence)
  (fold-right (lambda(x y) (append y (list x))) nil sequence))

(reverse (list 1 2 3 4))
;Value: (4 3 2 1)


(define (reverse sequence)
  (fold-left (lambda(x y) (cons y x)) nil sequence))

(reverse (list 1 2 3 4))
;Value: (4 3 2 1)