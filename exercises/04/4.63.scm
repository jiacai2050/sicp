(rule (grandson ?grandpa ?grandson)
  (and (son? ?father ?grandson)
       (son? ?grandpa ?father)))

(rule (all-son ?person ?son)
  (or (son ?person ?son)
      (and (son ?spouse ?son)
           (wife ?spouse ?person))))
