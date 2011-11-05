;; FIXME: FAKE
(library (implbase lib write-char-external)
         (export write-char-external)
         (import 
           (scheme write)
           (scheme base))
         (begin

(define (write-char-external obj port)
  (write obj port))

))
