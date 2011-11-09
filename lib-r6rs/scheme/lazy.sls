#!r6rs
(library (scheme lazy)
         (export delay eager force lazy)
         (import (impl lazy)))
