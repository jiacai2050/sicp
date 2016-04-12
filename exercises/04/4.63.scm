(rule (grandson ?grandpa ?grandson)
  (and (son? ?grandson ?father)
       (son? ?father ?grandpa)))

(rule (all-son ?persion ?son)
  (or (son ?son ?persion)
      (and (son ?son ?spouse)
           (wife ?spouse ?persion))))
