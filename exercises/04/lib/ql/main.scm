;  驱动循环和实例化

(define (input-prompt "Query input:"))
(define (output-prompt "Query output:"))

(define (query-drive-loop)
  (prompt-for-input input-prompt)
  (let ((q (query-syntax-process (read))))
    (cond
      ((assertion-to-be-added? q)
        (add-rule-or-assertion! (add-assertion-body q))
        (newline)
        (display "Assertion added to data base.")
        (query-drive-loop))
      (else
        (newline)
        (display output-prompt)
        (display-stream
          (stream-map
            (lambda (frame)
              (instantiate q
                           frame
                           (lambda (v f)
                             (contract-question-mark v))))
            (qeval q (singleton-stream '()))))
        (query-drive-loop)))))

(define (instantiate exp frame unbound-var-handler)
  (define (copy exp)
    (cond ((var? exp)
            (let ((binding (binding-in-frame exp frame)))
              (if binding
                (copy (binding-value binding))
                (unbound-var-handler exp frame))))
          ((pair? exp)
            (cons (copy (car exp)) (copy (cdr exp))))
          (else exp)))
  (copy exp))

; 求值器

(define (qeval query frame-stream)
  (let ((qproc (get (type query) 'qeval)))
    (if qproc
      (qproc (contents query) frame-stream)
      (simple-query query frame-stream))))

(define (simple-query query-pattern frame-stream)
  (stream-flatmap
    (lambda (frame)
      (stream-append-delayed
        (find-assertions query-pattern frame)
        (delay (apply-rules query-pattern frame))))
    frame-stream))
