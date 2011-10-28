#!r6rs
(library (scheme complex)
         (export 
;; from chibi-scheme
angle imag-part magnitude make-polar make-rectangular real-part)
         (import (impl complex)))
