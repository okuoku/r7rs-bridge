(library (srfi i98)
         (export get-environment-variable
                 get-environment-variables)
         (import (srfi :98 os-environment-variables)))
