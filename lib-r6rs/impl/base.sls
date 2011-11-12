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
                 (only (srfi i13)
                       string-map)
                 (srfi i0)
                 (srfi i23)
                 (srfi i9)
                 (srfi i39)
                 (r7b-util metadata)
                 )
         
;; R7RS-bridge format doesn't allow (begin (import ...) ...)
(define-syntax import
  (lambda (x)
    (syntax-case x ()
      ((_ ...) (assertion-violation 'import
                                    "Not allowed here..")))))

(define-syntax syntax-error
  (lambda (x)
    (syntax-case x ()
      ((_ message args ...) (syntax-violation 'syntax-error
                                              #'message
                                              (quote  #'(args ...)))))))
;; R7RS error object will be mapped to R6RS condition object
(define error-object? condition?)

(define (error-object-irritants obj) 
  (and (irritants-condition? obj)
       (condition-irritants obj)))

(define (error-object-message obj)
  (and (message-condition? obj)
       (condition-message obj)))

;; FIXME:
(define char-ready? 0)
(define u8-ready? 0)

;; FIXME: use metadata to retrive port state
(define (port-open? port) #t)

(define %buffer-port-id '*buffer-port*)
(define (%get-buffered-data port)
  (let ((d (metadata-ref port)))
    (unless d 
      (assertion-violation '%get-buffered-data
                           "Lost accumulated data...(premature collection?)"
                           port))
    (unless (eq? (car d) %buffer-port-id)
      (assertion-violation '%get-buffered-data
                           "something wrong with the metadata"
                           d))
    ((cdr d))))

(define get-output-bytevector %get-buffered-data)
(define get-output-string %get-buffered-data)

(define (%create-buffer proc)
  (lambda ()
    (let-values (((port getter) proc))
                (metadata-set! port (cons %buffer-port-id getter)))))

(define open-output-bytevector (%create-buffer open-bytevector-output-port))
(define open-output-string (%create-buffer open-string-output-port))

(define (open-input-bytevector bv) (open-bytevector-input-port bv))
(define open-input-string open-string-input-port)

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

(define-syntax define-values
  (lambda (x)
    (syntax-case x ()
      ((_ (val ...) body)
       (with-syntax (((name ...)
                      (generate-temporaries #'(val ...)))
                     ((tmp ...)
                      (generate-temporaries #'(val ...))))
         #'(begin
             (define name #f)
             ...
             (define bogus
               (begin
                 (call-with-values (lambda () body)
                                   (lambda (tmp ...)
                                     (set! name tmp)
                                     ...
                                     ))))
             (define val name)
             ...
             ))))))

(define (exact-integer? i) (and (integer? i) (exact? i)))

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

(define peek-u8 
  (case-lambda
    (() (peek-u8 (current-input-port)))
    ((port)
     (lookahead-u8 port))))

(define read-bytevector 
  (case-lambda
    ((len) (read-bytevector len (current-input-port)))
    ((len port) (get-bytevector-n port len))))

(define read-bytevector!
  (case-lambda
    ((bv start end)
     (read-bytevector! bv start end (current-input-port)))
    ((bv start end port)
     (get-bytevector-n! port bv start (- end start)))))

(define read-line
  (case-lambda 
    (() (read-line (current-input-port)))
    ((port) (get-line port))))

(define write-u8
  (case-lambda
    ((obj) (write-u8 obj (current-output-port)))
    ((obj port) (put-u8 port obj))))

(define read-u8
  (case-lambda
    (() (read-u8 (current-input-port)))
    ((port) (get-u8 port))))

(define (string->vector str) (list->vector (string->list str)))
(define (vector->string vec) (list->string (vector->list vec)))
(define (vector-copy vec) (list->vector (vector->list vec)))

(define write-bytevector
  (case-lambda
    ((bv port)
     (put-bytevector port bv))
    ((bv) (write-bytevector bv (current-output-port))))) 

(define write-partial-bytevector
  (case-lambda
    ((bv start end) (write-partial-bytevector bv start end 
                                              (current-output-port)))
    ((bv start end port)
     (put-bytevector port bv start (- end start)))))

)
