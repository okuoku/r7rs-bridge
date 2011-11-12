#!r6rs
(library (scheme division)
         (export
;; from R7RS draft 4
ceiling-quotient ceiling-remainder ceiling/ centered-quotient centered-remainder
centered/ euclidean-quotient euclidean-remainder euclidean/ floor-quotient
floor-remainder floor/ round-quotient round-remainder round/ truncate-quotient
truncate-remainder truncate/
          )
         (import (r7b-impl division)))
