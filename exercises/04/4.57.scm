
(rule (can-replace p1 p2)
  (and (job p1 ?job1)
       (job p2 ?job2)
       (or (same? job1 job2)
           (can-do-job job1 job2))
       (not (same p1 p2))))

; a)
(can-replace ?x (Fect Cy D))

; b)
(and (can-replace ?p1 ?p2)
	(salary ?p1 ?salary1)
	(salary ?p2 ?salary2)
	(lisp-value < ?salary1 ?salary2))
