(load "2.36.scm")

(define nil '())

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda(row) (dot-product v row)) m))

(define (transpose mat)
  (accumulate-n cons nil mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda(row) (matrix-*-vector cols row)) m)))

(define m (list (list 1 2 3)
                (list 4 5 6)
                (list 7 8 9)))

(define v (list 1 2 3 4))

(matrix-*-vector m v)
;Value: (30 56 80)

(transpose m)
;Value: ((1 4 7) (2 5 8) (3 6 9))

(matrix-*-matrix m m)
;Value: ((30 36 42) (66 81 96) (102 126 150))