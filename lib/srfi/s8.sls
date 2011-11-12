(library (srfi s8)
         (export receive)
         (import (scheme base))
         (begin
  
;; from SRFI
(define-syntax receive
  (syntax-rules ()
    ((_ f exp b0 b1 ...)
     (call-with-values (lambda () exp)
                       (lambda f b0 b1 ...))))) 
))
