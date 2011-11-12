#!r6rs
(library (r7b-util eval)
         (export interaction-environment
                 load
                 environment ;; R6RS
                 eval
                 null-environment scheme-report-environment)
         (import (rnrs)
                 (yuni util files)
                 (primitives 
                   ex:destructive-eval!
                   ex:interaction-environment)
                 (rename (rnrs load) (load load:nmosh)))

(define (interaction-environment) (ex:interaction-environment))

(define load
  (case-lambda
    ((file env)
     (let ((source (file->sexp-list file)))
       (for-each (lambda (e) (ex:destructive-eval! e env) source))))
    ((file) (load:nmosh file))))

;; FIXME: Always assume env is mutable
;; R7RS specifies (environment ...) envs are immutable
(define (eval x env)
  (ex:destructive-eval! x env))

)
