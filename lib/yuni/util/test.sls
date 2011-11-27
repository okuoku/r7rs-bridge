(library (yuni util test)
         (export test test-begin test-end)
         (import 
           ;(yuni compat test-core)
           (except  (yuni scheme)
                    syntax-rules
                    ) 
           (only (rnrs) syntax-rules)
           )


(define tes 0)
(define fail 0)

(define (test-count)
  (set! tes (+ tes 1)))

(define (fail-count)
  (set! fail (+ fail 1)))

;; 
(define (test-begin . x) 'ok)
(define (test-end . x) 
  (newline) (newline)
  (write (list 'test: tes 'fail: fail))
  'ok)

(define-syntax test-run
  (syntax-rules ()
    ((_ #(value ...) form)
     (begin
       (display (list 'WARNING: "vector quoted" '#(value ...)))
       (newline)
       (test-run '#(value ...) form)) )
    ((_ value form)
     (begin
       (test-count)
       (let ((v form))
         (unless (equal? v value)
           (fail-count)
           (write (list 'ERROR 'EXPECTED: value 'ACTUAL v 'form: 'form))
           (newline) (newline)))))))

(define-syntax test
  (syntax-rules ()
    ((_ val form)
     (guard
       (e
         (else 
           (fail-count)
           (write (list 'ERROR 'exception: e 'form: 'form))
           (newline) (newline)))
       (test-run val form)))))

)
