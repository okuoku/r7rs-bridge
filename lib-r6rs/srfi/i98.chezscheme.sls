(library (srfi i98)
         (export get-environment-variable
                 get-environment-variables)
         (import (chezscheme))
(define get-environment-variable getenv)
(define (get-environment-variables)
  (assertion-violation 'get-environment-variables
                       "Unimplemented"))
)
