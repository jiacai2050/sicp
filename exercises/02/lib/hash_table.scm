;为2.4.3数据导向的程序设计和可加性做准备，提供基本操作get与put
;参考
;http://stackoverflow.com/a/19114031/2163429
(define *op-table* (make-hash-table))

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) #f))

(define (all_keys)
  (hash-table/key-list *op-table*))
