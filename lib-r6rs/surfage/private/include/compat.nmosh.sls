; modified for nmosh
(library (surfage private include compat)
  (export
    search-paths)
  (import
    (rnrs base)
    (primitives prefix-list))

  (define (search-paths)
    prefix-list)
)
