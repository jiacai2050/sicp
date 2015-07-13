(define (make-rect p1 p2)
  (cons p1 p2))

(define (width r)
  (let ((p1 (car r))
        (p2 (cdr r)))
    (abs
      (x-point p1)
      (x-point p2))))

(define (heigth r)
  (let ((p1 (car r))
        (p2 (cdr r)))
    (abs
      (y-point p1)
      (y-point p2))))

(define (area r)
  (* (width r) (heigth r)))

(define (perimeter r)
  (* x (width r) (heigth r)))

;第二种
(define (make-rect a w h) 
  (cons a (cons w h)))

; rectangle selectors
(define (rect-width r)
  (car (cdr r)))

(define (rect-height r)
  (cdr (cdr r)))