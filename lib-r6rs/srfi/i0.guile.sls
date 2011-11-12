(library (srfi i0)
         (export cond-expand)
         (import (rnrs))
(define-syntax cond-expand
  (lambda (x)
    (syntax-case x ()
      ((_ ...) (assertion-violation 
                            'cond-expand
                            "unsupported feature")))))
)
