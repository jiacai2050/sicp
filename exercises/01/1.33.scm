(define (filtered-accumulate valid? combiner null-value term a next b)
  (if (> a b)
    null-value
    (if (valid? a)
      (combiner (term a)
                (filtered-accumulate valid? combiner null-value term (next a) next b))
      (filtered-accumulate valid? combiner null-value term (next a) next b))))

(define (identity x) x)
(define (inc x) (+ 1 x))

(define (sum-of-prime a b)
  (filtered-accumulate prime? + 0 identity a inc b))

(define (product-of-gcd-n n)
  (define (valid? a)
    (= (gcd a n) 1))
  (filtered-accumulate valid? * 1 identity a inc b))