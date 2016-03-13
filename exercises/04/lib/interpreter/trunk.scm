;; 4.2.2 槽的实现

(define (delay-it exp env)
  (list 'thunk exp env))

(define (trunk? obj)
  (tagged-list? obj 'thunk))

(define (thunk-exp thunk)
  (cadr thunk))

(define (thunk-env thunk)
  (caddr thunk))

(define (evaluated-thunk? obj)
  (tagged-list? obj 'evaluated-thunk))

(define (thunk-value evaluated-thunk)
  (cadr evaluated-thunk))

(define (force-it obj)
  (cond ((thunk? obj)
          (let ((result (actual-value (thunk-exp obj) (thunk-env obj))))
            (set-car! obj 'evaluated-thunk)
            (set-car! (cdr obj) result)
            (set-cdr! (cdr obj) '())   ; forget unneeded env
            result))
        ((evaluated-thunk? obj)
          (thunk-value obj))
        (else obj)))
