; 本题和 2.42 表示方法一样，用一个list表示一种解法，比如四皇后问题，解法(A B C D)表示，第一个皇后在位置A，第二个皇后在位置B，第三个皇后在位置C，第四个皇后在位置D，用list的位置表示了皇后的次序。

; https://github.com/jiacai2050/sicp/blob/master/exercises/02/2.42_2.43.md#242


(define (check-current-diagonal? current-postion rest distance-to-current)
  (if (null? rest)
    #f
    (or (= (- current-postion distance-to-current) (car rest))
        (= (+ current-postion distance-to-current) (car rest))
        (check-current-diagonal? current-postion (cdr rest) (+ distance-to-current 1)))))

(define (in-diagonal? positions)
  (if (null? positions)
    #f
    (or (in-diagonal (car positions) (cdr positions) 1)
        (in-diagonal? (cdr positions)))))

(define (collide? positions)
  (or (not (distinct? positions))
      (in-diagonal? positions)))

(define (eight-queen)
  (let ((q1 (amb 1 2 3 4 5 6 7 8))
        (q2 (amb 1 2 3 4 5 6 7 8))
        (q3 (amb 1 2 3 4 5 6 7 8))
        (q4 (amb 1 2 3 4 5 6 7 8))
        (q5 (amb 1 2 3 4 5 6 7 8))
        (q6 (amb 1 2 3 4 5 6 7 8))
        (q7 (amb 1 2 3 4 5 6 7 8))
        (q8 (amb 1 2 3 4 5 6 7 8)))
    (require (not (collide? (list q1 q2 q3 q4 q5 q6 q7 q8))))))
