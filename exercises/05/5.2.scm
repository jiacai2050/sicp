(controller
  test-counter
    (test (op >) (reg counter) (reg n))
    (branch (label fact-done))
    (assign product (op *) (reg counter) (reg product))
    (assign counter (op +) (reg counter) (const 1))
    (goto (label-counter))
  fact-done)
