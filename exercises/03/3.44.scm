```
(load "lib/protected_account.scm")
(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))
```

上面是 Ben 提出的写法，Louis 说这里有问题，需要使用更复杂精细的方法，例如在处理交换问题中所用的方法。

其实 Louis 这里多此一举了，这个`transfer`于`exchange`不同的地方在于，各个账户只使用了一次，这样只要保证一个账户内`withdraw`与`deposit`是串行化的就可以了，没必要使用`exchange`中所用的方法。