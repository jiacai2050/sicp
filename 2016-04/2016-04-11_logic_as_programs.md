# 逻辑程序设计语言的解释器——查询语言的三要素

- `基本元素`，简单查询

    ```
    (job ?persion (computer programmer))
    ```    

- `组合手段`，复合查询

    ```
    (and
      (job ?persion (computer programmer))
      (address ?persion ?where))
    ```

- `抽象手段`，规则

    ```
    (rule ⟨conclusion⟩ ⟨body⟩)

    (rule (lives-near ?persion-1 ?persion-2)
      (and (address ?persion-1 (?town . ?rest-1))
           (address ?persion-2 (?town . ?rest-2))
           (not (same ?persion-1 ?persion-2))))
    ```        

## 将逻辑看作程序

- 我们可以认为，一条规则就是一个逻辑蕴含（logical implication）：

> 如果对所有模式变量的一个赋值满足规则的体，那么它就满足其结论。因此，我们可以认为查询语言有着一种基于有关规则，执行逻辑推理的能力。

> If an assignment of values to pattern variables satisfies the body, then it satisfies the conclusion. Consequently, we can regard the query language as having the ability to perform logical deductions based upon the rules. 

```
(rule (append-to-form () ?y ?y))
(rule (append-to-form (?u . ?v) ?y (?u . ?z))
      (append-to-form ?v ?y ?z))


;;; Query input:
(append-to-form (a b) (c d) ?z)
;;; Query results:
(append-to-form (a b) (c d) (a b c d))


;;; Query input:
(append-to-form (a b) ?y (a b c d))
;;; Query results:
(append-to-form (a b) (c d) (a b c d))


;;; Query input:
(append-to-form ?x ?y (a b c d))
;;; Query results:
(append-to-form () (a b c d) (a b c d))
(append-to-form (a) (b c d) (a b c d))
(append-to-form (a b) (c d) (a b c d))
(append-to-form (a b c) (d) (a b c d))
(append-to-form (a b c d) () (a b c d))

```
