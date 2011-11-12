#!r6rs
(library (r7b-impl time)
        (export current-jiffy current-second jiffies-per-second)
        (import (rnrs))
(define current-second 0)
(define current-jiffy 0)
(define jiffies-per-second 0)
)
