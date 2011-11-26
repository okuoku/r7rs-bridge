#!r6rs
(library (r7b-util bytevector-buffer)
         (export
           get-output-bytevector
           open-output-bytevector
           )
         (import (primitives get-output-bytevector
                             open-output-bytevector))
)
