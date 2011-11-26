(library (srfi i6)
         (export open-output-string
                 get-output-string
                 open-input-string)
         (import (rnrs) (ironscheme clr))

;;

(clr-using IronScheme.Runtime)

(define (open-output-string)
  (clr-new IronScheme.Runtime.StringWriter))

(define (get-output-string p)
  (clr-call IronScheme.Runtime.StringWriter GetBuffer p))

(define open-input-string open-string-input-port)
)
