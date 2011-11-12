#!r6rs
(library (scheme char)
         (export

;; from R7RS draft 4
char-alphabetic? char-ci<=? char-ci<? char-ci=? char-ci>=? char-ci>?
char-downcase char-foldcase char-lower-case? char-numeric? char-upcase
char-upper-case?  char-whitespace? digit-value string-ci<=? string-ci<?
string-ci=?  string-ci>=? string-ci>? string-downcase string-foldcase
string-upcase
   )
         (import (r7b-impl char))
)
