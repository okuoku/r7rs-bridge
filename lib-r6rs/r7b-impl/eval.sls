#!r6rs
(library (impl eval)
         (export environment eval null-environment scheme-report-environment)
         (import (rnrs) (rnrs eval))
         
(define null-environment 0)
(define scheme-report-environment 0)
         
)
