; modified for nmosh

;; Copyright (c) 2009 Derick Eddington.  All rights reserved.
;; Licensed under an MIT-style license.  My license is in the file
;; named LICENSE from the original collection this file is distributed
;; with.  If this file is redistributed with some other collection, my
;; license must also be included.

(library (surfage private platform-features)
  (export
    OS-features
    implementation-features)
  (import
    (rnrs)
    (only (mosh) host-os)
    (surfage private OS-id-features))
  
  (define (OS-features)
    (OS-id-features
      (host-os)
     '(("linux" linux posix)
       ("bsd" bsd posix)
       ("darwin" darwin posix)
       ("cygwin" linux posix) ; it-is-not-so-good-choice-for-us 
       ("win32" windows))))
  
  (define (implementation-features)
    '(mosh))
)
