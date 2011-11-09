#!r6rs
(library (scheme char normalization)
         (export string-ni<=? string-ni<? string-ni=? string-ni>=? string-ni>?)
         (import (impl char normalization)))
