#!r6rs
(library (scheme process-context)
         (export
;; from R7RS draft 4
command-line exit get-environment-variable get-environment-variables
)
         (import (impl process-context)))
