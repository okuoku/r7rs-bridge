;; FIXME: FAKE
(library (implbase lib write-string-external)
         (export write-string-external)
         (import 
           (scheme write)
           (scheme base))
         (begin

(define (write-string-external obj port)
  (write obj port))

))
