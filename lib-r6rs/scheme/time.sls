#!r6rs
(library (scheme time)
        (export current-second current-jiffy jiffies-per-second)
        (import (impl time)))
