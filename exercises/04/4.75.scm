(put 'unique 'qeval uniquely-asserted)

(define (uniquely-asserted pattern frame-stream)
  (stream-flatmap
    (lambda (frame)
      (let ((s (qeval (negated-query pattern)
                      (singleton-stream frame))))
        (if (singleton-stream? s)
          s
          the-empty-stream)))
    frame-stream))

(define (singleton-stream? s)
  (and (not (stream-null? s))
       (stream-null? (cdr s))))


 ;;; Query input:
 (and (supervisor ?person ?boss)
      (unique (supervisor ?other ?boss)))

 ;;; Query output:
 (and (supervisor (Cratchet Robert) (Scrooge Eben))
      (unique (supervisor (Cratchet Robert) (Scrooge Eben))))
 (and (supervisor (Reasoner Louis) (Hacker Alyssa P))
      (unique (supervisor (Reasoner Louis) (Hacker Alyssa P))))
