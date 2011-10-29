#!r6rs
(library (impl file)
         (export 
;; from chibi-scheme

   call-with-input-file call-with-output-file
   delete-file file-exists?
   open-binary-input-file open-binary-output-file
   open-input-file open-output-file
   with-input-from-file with-output-to-file
   )
         (import (rnrs))
(define open-binary-input-file 0)
(define open-binary-output-file 0)
)
