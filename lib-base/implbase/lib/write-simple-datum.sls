(library (implbase lib write-simple-datum)
         (export write-simple-datum)
         (import 
           (scheme base)
           (implbase lib write-char-external)
           (implbase lib write-string)
           (implbase lib write-string-external)
           ;(implbase lib write-port)
           ;(implbase lib write-procedure)
           )
         (begin

(define write-integer write-number)
(define (write-number obj port)
  (write-string (number->string obj) port))
(define (write-port obj port)
  (write-string "#<PORT>" port))
(define (write-procedure obj port)
  (write-string "#<PROCEDURE>" port))

(define (write-vector-itr obj idx stop port)
  (write-simple-datum (vector-ref obj idx) port)
  (let ((next (+ 1 idx)))
    (cond 
      ((not (= stop next))
       (write-char #\space port)
       (write-vector-itr obj next stop port)))))

(define (write-vector obj port)
  (write-string "#(" port)
  (let ((len (vector-length obj)))
    (if (not (= len 0))
      (write-vector-itr obj 0 (vector-length obj) port)))
  (write-string ")" port))

(define (write-bytevector-external-itr obj idx stop port)
  (write-integer (bytevector-u8-ref obj idx) port)
  (let ((next (+ 1 idx)))
    (cond 
      ((not (= stop next))
       (write-char #\space port)
       (write-bytevector-external-itr obj next stop port)))))

(define (write-bytevector-external obj port)
  (write-string "#vu8(" port)
  (let ((len (vector-length obj)))
    (if (not (= len 0))
      (write-bytevector-external-itr obj 0 (bytevector-length obj) port)))
  (write-string ")" port))

(define (write-pair-itr obj port)
  (let ((a (car obj))
        (d (cdr obj)))
    (cond 
      ((pair? d) ;; part of list
       (let ((da (car d))
             (dd (cdr d)))
         (write-simple-datum a port)
         (write-char #\space port)
         (write-simple-datum da port)
         (write-char #\space port)
         (write-pair-itr dd port)))
      (else
        (write-simple-datum a port)
        (write-string " . " port)
        (write-simple-datum d port)))))

(define (write-pair obj port)
  (write-char #\( port)
  (write-pair-itr obj port)
  (write-char #\) port))

(define (write-simple-datum obj port)
  (cond
    ((boolean? obj)
     (if obj
       (write-string "#t" port)
       (write-string "#f" port)))
    ((pair? obj)
     (write-pair obj port))
    ((symbol? obj)
     (write-string (symbol->string obj) port))
    ((number? obj)
     (write-number obj port))
    ((char? obj)
     ;; NB: write-char doesn't write external representation
     ;; despite of its name..
     (write-char-external obj port))
    ((string? obj)
     (write-string-external obj port))
    ((vector? obj)
     (write-vector obj port))
    ((bytevector? obj)
     (write-bytevector-external obj port))
    ((port? obj)
     (write-port obj port))
    ((procedure? obj)
     (write-procedure obj port))
    ((null? obj)
     (write-string "'()" port))))

))

