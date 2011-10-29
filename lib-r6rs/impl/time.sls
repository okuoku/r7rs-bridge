#!r6rs
(library (impl time)
        (export current-second current-jiffy jiffies-per-second)
        (import (rnrs))
(define current-second 0)
(define current-jiffy 0)
(define jiffies-per-second 0)
)
