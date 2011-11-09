#!r6rs
(library (impl complex)
         (export 
;; from R7RS draft 4
angle imag-part magnitude make-polar make-rectangular real-part
)
         (import (rnrs)))
