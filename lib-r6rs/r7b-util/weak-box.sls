(library (r7b-util weak-vectors)
         (export make-weak-vector
                 weak-vector-ref
                 weak-vector-set!)
         (import (rnrs))
         
(define (make-weak-vector size) (make-vector size))         
(define weak-vector-ref vector-ref)
(define weak-vector-set! vector-set!)
         
(display "WARNING: Using FAKE implementation of weak-vectors." 
         (current-error-port))
)
