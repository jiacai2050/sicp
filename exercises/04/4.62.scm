(rule (last-pair (?last) (?last)))

(rule (last-pair (?first . ?second) (?last))
      (last-pair ?second (?last)))

(last-pair (3) ?x)
(last-pair (1 2 3) ?x)
(last-pair (2 ?x) (3))

;上面这三个都能工作，但是下面这个无法工作，因为这是结果有无穷个
(last-pair ?x (3))
