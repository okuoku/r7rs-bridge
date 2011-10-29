#!r6rs
(library (impl char)
         (export
;; from chibi-scheme
   char-alphabetic? char-ci<=? char-ci<? char-ci=? char-ci>=? char-ci>?
   char-downcase char-foldcase char-lower-case? char-numeric?
   char-upcase char-upper-case? char-whitespace? numeric-digit
   string-ci<=? string-ci<? string-ci=? string-ci>=? string-ci>?
   string-downcase string-foldcase string-upcase
   )
         (import (rnrs))
(define numeric-digit 0)
)
