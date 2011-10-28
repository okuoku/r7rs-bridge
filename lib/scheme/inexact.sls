#!r6rs
(library (scheme inexact)
         (export
;; from chibi-scheme
 acos asin atan cos exp finite? log nan? sin sqrt tan
 )
         (import (impl inexact)))
