(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
        (sum term (next a) next b))))

(define (add1 x)
  (+ x 1))

(define (cube x) (* x x x))

(define (simpson f a b n)
  (define (h)
    (/ (- b a) n))
  (define (y k)
    (f (+ a (* k (h)))))
  (define (simpson-term k)
    (cond
      ((or (= k n) (= k 0)) (y k))
      ((even? k) (* 2 (y k)))
      (else (* 4 (y k)))))
  (/ (* (h) (sum simpson-term 0 add1 n))
     3.0))

(simpson cube 0 1 100)
;Value: .25
(simpson cube 0 1 1000)
;Value: .25