
;(rule (end-with-grandson? (?tail))
;  (lisp-value eq? 'grandson ?tail))

; 上面是我第一次的写法，后来发现下面这种更好的方式

(rule (end-with-grandson (grandson)))

(rule (end-with-grandson? (?f . ?tail))
  (end-with-grandson? ?tail))

(rule ((grandson) ?x ?y)
      (grandson ?x ?y))

(rule ((great . ?rel) ?x ?y)
  (and (end-with-grandson? ?rel)
       (?rel (grandson ?x) ?y)))


; ((great grandson) ?g ?ggs)
; (?relationship Adam Irad)
