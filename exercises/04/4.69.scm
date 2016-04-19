(rule (end-with-grandson? (tail))
  (lisp-value eq? 'grandson tail))

(rule (end-with-grandson? (f . tail))
  (end-with-grandson? tail))

(rule ((great . ?rel) ?x ?y)
  (and (end-with-grandson? ?rel)
       (?rel (grandson ?x) ?y)))


; ((great grandson) ?g ?ggs)
; (?relationship Adam Irad)
