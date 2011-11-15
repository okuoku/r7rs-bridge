#!r6rs
(library (r7b-util string-buffer)
         (export get-output-string open-output-string)
         (import (only  (system) get-output-string open-output-string)))
