;; Seems broken
(library (r7b-util weak-eq-hashtable)
         (export make-weak-eq-hashtable
                 weak-hashtable-set!
                 weak-hashtable-ref)
         (import (rnrs) (srfi srfi-69))

;; FIXME: What does 5 mean??
(define (make-weak-eq-hashtable)
  (make-hash-table eq? hash-by-identity 5 #:weak 'key-or-value))

(define weak-hashtable-set! hash-table-set!)
(define weak-hashtable-ref hash-table-ref/default)

)
