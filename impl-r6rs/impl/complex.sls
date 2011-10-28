#!r6rs
(library (impl complex)
         (export 
;; from chibi-scheme
angle imag-part magnitude make-polar make-rectangular real-part)
         (import (rnrs)))
