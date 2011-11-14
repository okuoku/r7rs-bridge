(library (r7b-util weak-box)
         (export make-weak-box
                 weak-box-ref
                 weak-box-set!)
         (import (rnrs) (ikarus))
(define (make-weak-box)
  (weak-cons #f #f))
(define (weak-box-ref wb)
  (car wb))
(define (weak-box-set! wb obj)
  (set-car! wb obj))
)
