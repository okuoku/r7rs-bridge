#!r6rs
(library (scheme process-context)
         (export
;; from chibi-scheme
get-environment-variable get-environment-variables command-line exit)
         (import (impl process-context)))
