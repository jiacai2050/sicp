; a) Ben Bitdiddle 的所有下属的名字，以及他们的住址

(and (supervisor ?name (Ben Bitdiddle))
     (address ?name ?address))

; b) 所有工资少于 Ben Bitdiddle 的人，以及他们的工资和 Ben Bitdiddle 的工资

(and (salary (Ben Bitdiddle) (?Ben-salary))
     (salary ?x ?others-salary)
     (list-value > ?Ben-salary ?others-salary))

; c) 所有不是由计算机分部的人管理的人，以及他们的上司和工作

(and
  (not (job ?name (computer . ?title)))
  (supervisor ?name ?supervisor)
  (job ?supervisor ?supervisor-job))
