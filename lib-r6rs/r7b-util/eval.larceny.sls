#!r6rs
(library (r7b-util eval)
         (export interaction-environment
                 load
                 environment ;; R6RS
                 eval
                 null-environment scheme-report-environment)
         (import (rnrs)
                 (rnrs r5rs)
                 (rnrs eval)
                 (primitives interaction-environment)
                 (rename 
                   (larceny load)
                   (load larceny:load)))

(define load
  (case-lambda
    ((file env)
     (assertion-violation 'load
                          "2 argument load is not supported in Larceny"
                          file env))
    ((file) (larceny:load file))))

)
