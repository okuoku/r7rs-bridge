#!r6rs
(library (scheme time)
        (export current-jiffy current-second jiffies-per-second)
        (import (impl time)))
