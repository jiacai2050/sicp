;  Warbucks Oliver 公司大老板
(address (Warbucks Oliver) (Swellesley (Top Heap Road)))
(job (Warbucks Oliver) (administration big wheel))
(salary (Warbucks Oliver) 150000)

; 大老板秘书
(address (Aull DeWitt) (Slumerville (Onion Square) 5))
(job (Aull DeWitt) (administration secretary))
(salary (Aull DeWitt) 25000)
(supervisor (Aull DeWitt) (Warbucks Oliver))


; 计算机分部： 一个计算机大师，两个程序员工，一个技师，还有一个实习生
(address (Bitdiddle Ben) (Slumerville (Ridge Road) 10))
(job (Bitdiddle Ben) (computer wizard))
(salary (Bitdiddle Ben) 60000)
(supervisor (Bitdiddle Ben) (Warbucks Oliver))

(address (Hacker Alyssa P) (Cambridge (Mass Ave) 78))
(job (Hacker Alyssa P) (computer programmer))
(salary (Hacker Alyssa P) 40000)
(supervisor (Hacker Alyssa P) (Bitdiddle Ben))

(address (Fect Cy D) (Cambridge (Ames Street) 3))
(job (Fect Cy D) (computer programmer))
(salary (Fect Cy D) 35000)
(supervisor (Fect Cy D) (Bitdiddle Ben))

(address (Tweakit Lem E) (Boston (Bay State Road) 22))
(job (Tweakit Lem E) (computer technician))
(salary (Tweakit Lem E) 25000)
(supervisor (Tweakit Lem E) (Bitdiddle Ben))

(address (Reasoner Louis) (Slumerville (Pine Tree Road) 80))
(job (Reasoner Louis) (computer programmer trainee))
(salary (Reasoner Louis) 30000)
(supervisor (Reasoner Louis) (Hacker Alyssa P))


; 会计分部：一位主管会计和他的助手

(address (Scrooge Eben) (Weston (Shady Lane) 10))
(job (Scrooge Eben) (accounting chief accountant))
(salary (Scrooge Eben) 75000)
(supervisor (Scrooge Eben) (Warbucks Oliver))

(address (Cratcher Robert) (Allston (N Harvard Street) 16))
(job (Cratcher Robert) (accounting scrivener))
(salary (Cratcher Robert) 18000)
(supervisor (Cratcher Robert) (Scrooge Eben))


; 数据库中还包含一些断言，描述了从事某些工作的人还可以做另外一些种类的工作。
; 比如说，计算机大师还可以做计算机程序员和计算机技师：
(can-do-job (computer wizard) (computer programmer))
(can-do-job (computer wizard) (computer technician))

; 计算机程序员还可以做实习程序员的工作
(can-do-job (computer programmer) (computer programmer trainee))

(can-do-job (administration secretary) (administration big wheel))
