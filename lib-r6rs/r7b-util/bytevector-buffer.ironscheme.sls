#!r6rs
(library (r7b-util bytevector-buffer)
         (export
           get-output-bytevector
           open-output-bytevector)
         (import (rnrs) 
                 (ironscheme contracts)
                 (ironscheme clr))


;; This file based on IronScheme.Console/build/io/ports.ss
;; Slightly modified to use with r7b


;; Copyright (c) 2007,2008,2009,2010,2011 Llewellyn Pritchard 
;;
;;  See docs/LICENSE.IronScheme

; Import MemoryStream from system
(clr-using System.IO)

(define/contract (open-output-bytevector)
  (clr-new MemoryStream))

(define (get-output-bytevector p)
  (let ((r (clr-call MemoryStream ToArray p)))
    (clr-call MemoryStream SetLength p (clr-static-call
                                         Convert
                                         (ToInt64 Int32)
                                         0))
    r))

)
