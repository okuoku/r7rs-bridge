(library (srfi i6)
         (export open-output-string
                 get-output-string
                 open-input-string)
         (import 
           (only (rnrs) define open-string-input-port)
           (r7b-util string-buffer))
(define open-input-string open-string-input-port)
)
