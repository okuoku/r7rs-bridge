;; FIXME: FAKE
(library (implbase lib write-string)
         (export write-string)
         (import 
           (scheme write)
           (scheme base))
         (begin

(define (write-string obj port)
  (display obj port))

))
