; 第一条规则说明 一个列表中前两个元素是相邻的
(rule (?x next-to ?y in (?x ?y . ?u)))

; 这条规则说明 一个列表中，除第一个元素外，其余的元素也是相邻的
(rule (?x next-to ?y in (?v . ?z))
      (?x next-to ?y in ?z))


(?x next-to ?y in (1 (2 3) 4))
(1 next-to (2 3) in (1 (2 3) 4))
((2 3) next-to 4 in (1 (2 3) 4))

(?x next-to 1 in (2 1 3 1))
(2 next-to 1 in (2 1 3 1))
(3 next-to 1 in (2 1 3 1))
