#!r6rs
(library (impl base)
         (export

;; from R7RS draft 4
* + - ... / < <= = => > >= abs and append apply assoc assq assv begin
binary-port?  boolean? bytevector-copy bytevector-copy! bytevector-copy-partial
bytevector-copy-partial! bytevector-length bytevector-u8-ref bytevector-u8-set!
bytevector?  caaaar caaadr caaar caadar caaddr caadr caar cadaar cadadr
cadar caddar cadddr caddr cadr call-with-current-continuation
call-with-port call-with-values call/cc car case cdaaar cdaadr cdaar cdadar
cdaddr cdadr cdar cddaar cddadr cddar cdddar cddddr cdddr cddr cdr ceiling
char->integer char-ready? char<=? char<? char=? char>=? char>? char?
close-input-port close-output-port close-port complex? cond cond-expand cons
current-error-port current-input-port current-output-port define 
define-record-type define-syntax define-values denominator do dynamic-wind
else eof-object?  eq? equal? eqv?  error error-object-irritants 
error-object-message error-object?  even? exact->inexact exact-integer-sqrt
exact-integer?  exact? expt floor flush-output-port for-each gcd 
get-output-bytevector get-output-string guard if import inexact->exact
inexact? input-port? integer->char integer? lambda lcm length let let*
let*-values let-syntax let-values letrec letrec* letrec-syntax list list->string
list->vector list-copy list-ref list-set! list-tail list? make-bytevector 
make-list make-parameter make-string make-vector map max member memq memv min
modulo negative? newline not null? number->string number? numerator odd?
open-input-bytevector open-input-string open-output-bytevector
open-output-string or output-port? pair? parameterize peek-char peek-u8
port-open?  port? positive? procedure?  quasiquote quote quotient raise
raise-continuable rational? rationalize read-bytevector read-bytevector!
read-char read-line read-u8 real?  remainder reverse round set! set-car!
set-cdr!  string string->list string->number string->symbol string->utf8
string->vector string-append string-copy string-fill!  string-for-each
string-length string-map string-ref string-set! string<=?  string<? string=?
string>=?  string>? string? substring symbol->string symbol? syntax-error
syntax-rules textual-port? truncate u8-ready? unless unquote
unquote-splicing utf8->string values vector vector->list
vector->string vector-copy vector-fill! vector-for-each vector-length
vector-map vector-ref vector-set! vector?  when with-exception-handler
write-bytevector write-char write-partial-bytevector write-u8 zero?
   )
         (import (except (rnrs)
                         error
                         define-record-type)
                 (rnrs mutable-pairs)
                 (rnrs mutable-strings)
                 (rnrs r5rs)
                 (only (surfage s13 strings)
                       string-map)
                 (surfage s0 cond-expand)
                 (surfage s23 error)
                 (surfage s9 records)
                 (surfage s39 parameters)

                 )
         
(define (bytevector-copy-partial bv start end)
  (let ((ret (make-bytevector (- end start))))
    (define (itr cur)
      (unless (= (+ start cur) end) 
        (bytevector-u8-set! ret cur (bytevector-u8-ref bv (+ start cur)))
        (itr (+ cur 1))))
    (itr 0)
    ret))

(define (bytevector-copy-partial! from start end to at)
  (define (itr cur)
    (unless (= (+ start cur) end)
      (let ((val (bytevector-u8-ref from (+ start cur))))
        (bytevector-u8-set! to (+ at cur) val)
        (itr (+ cur 1)))))
  (itr 0))

(define char-ready? 0)
(define define-values 0)
(define error-object-irritants 0)
(define error-object-message 0)
(define error-object? 0)
(define exact-integer? 0)
(define get-output-bytevector 0)
(define get-output-string 0)
(define import 0)
(define (list-copy l) (map (lambda (e) e) l))
(define (list-set! l k obj) 
  (define (itr cur count)
    (unless (= count k) (itr (cdr cur) (+ count 1)))
    (set-car! cur obj))
  (itr l 0))
(define make-list
  (case-lambda
    ((k fil) (vector->list (make-vector k fil)))
    ((k) (make-list k 'unspecified))))
(define open-input-bytevector 0)
(define open-input-string 0)
(define open-output-bytevector 0)
(define open-output-string 0)
(define peek-u8 0)
(define port-open? 0)
(define read-bytevector 0)
(define read-bytevector! 0)
(define read-line get-line)
(define read-u8 get-u8)
(define (string->vector str) (list->vector (string->list str)))
(define syntax-error 0)
(define u8-ready? 0)
(define (vector->string vec) (list->string (vector->list vec)))
(define (vector-copy vec) (list->vector (vector->list vec)))
(define write-bytevector 0)
(define write-partial-bytevector 0)
(define write-u8 put-u8)

         
         )

