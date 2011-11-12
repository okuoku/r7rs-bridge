(library (r7b-util weak-eq-hashtable)
         (export make-weak-eq-hashtable
                 weak-hashtable-set!
                 weak-hashtable-ref)
         (import (rnrs))
(define weak-hashtable-set! hashtable-set!)
(define weak-hashtable-ref hashtable-ref)
(define make-weak-eq-hashtable make-eq-hashtable)

)
