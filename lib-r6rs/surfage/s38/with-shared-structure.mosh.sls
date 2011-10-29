;; mosh version. 

(library (surfage s38 with-shared-structure)
  (export (rename (read read-with-shared-structure)
                  (write/ss write-with-shared-structure)))
  (import (only (mosh) write/ss)
          (only (rnrs) read) ;; FIXME: 
          )
)
