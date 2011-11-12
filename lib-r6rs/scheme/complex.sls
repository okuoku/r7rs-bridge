#!r6rs
(library (scheme complex)
         (export 
;; from R7RS draft 4
angle imag-part magnitude make-polar make-rectangular real-part
)
         (import (r7b-impl complex)))
