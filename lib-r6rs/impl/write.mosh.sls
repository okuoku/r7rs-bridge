#!r6rs
(library (impl write)
         (export display write write-simple)
         (import  (rename (rnrs) (write write-simple))
                  (mosh))
(define write write/ss)
)
