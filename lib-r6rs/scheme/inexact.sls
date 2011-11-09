#!r6rs
(library (scheme inexact)
         (export
;; from R7RS draft 4
acos asin atan cos exp finite?  log nan? sin sqrt tan
 )
         (import (impl inexact)))
