#!r6rs
(library (scheme lazy)
         (export delay force lazy eager)
         (import (impl lazy)))
