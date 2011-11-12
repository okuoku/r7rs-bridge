#!r6rs
(library (scheme file)
         (export 
;; from R7RS draft 4
call-with-input-file call-with-output-file delete-file file-exists?
open-binary-input-file open-binary-output-file open-input-file
open-output-file with-input-from-file with-output-to-file
   )
         (import (r7b-impl file)))
