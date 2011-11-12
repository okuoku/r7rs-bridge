;; FIXME: FAKE
(library (implbase lib write-string)
         (export write-string)
         (import 
           (scheme base))
         (begin

(define (write-string obj port)
  (string-for-each (lambda (c) (write-char c port)) obj))

))
