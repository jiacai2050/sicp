(define (make-vect x y)
  (cons x y))

(define xor-vect car)
(define yor-vect cdr)

(define (add-vect v1 v2)
  (make-vect
    (+ (xor-vect v1) (xor-vect v2))
    (+ (yor-vect v1) (yor-vect v2))))

(define (scale-vect factor v)
  (make-vect
    (* factor (xor-vect v))
    (* factor (yor-vect v))))