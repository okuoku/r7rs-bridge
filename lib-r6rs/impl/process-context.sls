#!r6rs
(library (impl process-context)
         (export
;; from R7RS draft 4
command-line exit get-environment-variable get-environment-variables
)
         (import (rnrs) (surfage s98 os-environment-variables)))
