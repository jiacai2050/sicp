(car ''(abracadabra))
;相当于 
(car (quote (quote (abracadabra))))
;car把第一个quote后的对象作为一个list整体来看了

(cadr ''(abracadabra))
;这是返回的就是(abracadabra)了