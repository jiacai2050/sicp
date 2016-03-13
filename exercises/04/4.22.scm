
(load "4.6.scm")

(define (analyze-let exp)
  (analyze (let->combination exp)))
