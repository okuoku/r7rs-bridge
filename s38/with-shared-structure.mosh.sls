;; mosh version. 

(library (surfage s38 with-shared-structure)
  (export (rename (read read/ss)) write/ss)
  (import (only (mosh) write/ss)
          (only (rnrs) read) ;; FIXME: 
          )
)
