(sentence
  (simple-noun-phrase (article the) (noun professor))
  (verb-phrase
    (verb lectures)
    (prep-phrase (prep to)
                 (simple-noun-phrase (article the) (noun student)))
    (prep-phrase (prep in)
                 (simple-noun-phrase (article the) (noun class)))
    (prep-phrase (prep with)
                 (simple-noun-phrase (article the) (noun cat)))))

(sentence
  (simple-noun-phrase (article the) (noun professor))
  (verb-phrase
    (verb lectures)
    (prep-phrase (prep to)
                 (simple-noun-phrase
                   (article the)
                   (noun-phrase (noun student)
                                (prep-phrase (prep in)
                                             (simple-noun-phrase (article the) (noun class))))))
    (prep-phrase (prep with)
                 (simple-noun-phrase (article the) (noun cat)))))

(sentence
  (simple-noun-phrase (article the) (noun professor))
  (verb-phrase
    (verb lectures)
    (prep-phrase (prep to)
                 (simple-noun-phrase
                   (article the)
                   (noun-phrase (noun student)
                                (prep-phrase (prep in)
                                             (simple-noun-phrase (article the) (noun class)))
                                (prep-phrase (prep with)
                                             (simple-noun-phrase (article the) (noun cat))))))))


(sentence
  (simple-noun-phrase (article the) (noun professor))
  (verb-phrase
    (verb lectures)
    (prep-phrase (prep to)
                 (simple-noun-phrase
                   (article the)
                   (noun-phrase (noun student)
                                (prep-phrase (prep in)
                                             (simple-noun-phrase
                                               (article the)
                                               (noun-phrase)
                                                 (noun class)
                                                 (prep-phrase (prep with)
                                                              (simple-noun-phrase (article the) (noun cat))))))))))

(sentence
  (simple-noun-phrase (article the) (noun professor))
  (verb-phrase
    (verb lectures)
    (prep-phrase (prep to)
                 (simple-noun-phrase (article the) (noun student)))
    (prep-phrase (prep in)
                 (simple-noun-phrase
                   (article the)
                   (noun-phrase
                     (noun class)
                     (prep-phrase (prep with)
                                  (simple-noun-phrase (article the) (noun cat))))))))


; 上面 5 种情况前三个比较好找，后面两个用了些功夫，其实核心的就一个
; 谓语、名词后面可以有介词，然后排列组合就可以了
