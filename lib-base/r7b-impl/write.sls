(library (impl write)
         (export display write write-simple)
         (import (implbase lib readerwriter)
                 (implbase lib write-simple-datum)
                 (scheme case-lambda)
                 (scheme base))
         (begin

(define write-simple
  (case-lambda
    ((obj port)
     (write-simple-datum obj port))
    ((obj)
     (write-simple-datum obj (current-output-port)))))

(define write
  (case-lambda
    ((obj port)
     (write/ss obj port))
    ((obj)
     (write/ss obj (current-output-port)))))

(define display write)

))

