
(define (text-of-quotation exp)
  (cadr exp))

(define (quote->lazy-list exp)
  (define (iter text)
    (if (null? text)
      (list 'quote '())
      (list 'cons
            (list 'quote (car text))
            (iter (cdr text)))))
  (let ((text (text-of-quotation exp))
    (if (pair? text)
      (iter text)
      text)))
