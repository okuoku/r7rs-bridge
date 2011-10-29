#!r6rs
(library (impl process-context)
         (export
;; from chibi-scheme
get-environment-variable get-environment-variables command-line exit)
         (import (rnrs)))
