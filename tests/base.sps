(import (scheme base)
        (scheme write))


;; Examples Took from SRFI-46

;;; Examples of the user-specified ellipsis token extension

;;; Utility macro for CPS macros
(define-syntax apply-syntactic-continuation
  (syntax-rules ()
    ((apply-syntactic-continuation (?k ?env ...) . ?args)
     (?k ?env ... . ?args))))

;;; Generates a list of temporaries, for example to implement LETREC
;;; (see below), and 'returns' it by CPS.
(define-syntax generate-temporaries
  (syntax-rules ()
    ((generate-temporaries ?origs ?k)
     (letrec-syntax
         ((aux (syntax-rules ::: ()
                 ;; We use a trick here: pass the continuation again
                 ;; to AUX in case it contains ellipsis.  If we stuck
                 ;; it right into AUX's template, AUX would process the
                 ;; ellipsis in ?K as ellipsis for something in the AUX
                 ;; macro.
                 ((aux ?temps () ?k*)
                  (apply-syntactic-continuation ?k* ?temps))
                 ;; Be careful about the ellipsis!
                 ((aux (?temp :::) (?x ?more :::) ?k*)
                  (aux (?temp ::: new-temp)
                       (?more :::)
                       ?k*)))))
       (aux () ?origs ?k)))))

;;; Instead of having lots of auxiliary clauses in LETREC, like in the
;;; R5RS sample implementation, we use GENERATE-TEMPORARIES.  Instead
;;; of 'returning,' like an ordinary function, we create a continuation
;;;  for GENERATE-TEMPORARIES with LET-SYNTAX.  Since this continuation
;;; uses ellipsis, we must use the ellipsis token extension.
(define-syntax letrec/46
  (syntax-rules ()
    ((letrec ((?var ?init) ...) ?body1 ?body2 ...)
     (let-syntax
         ((k (syntax-rules ::: ()
               ;; Use the same trick as with the continuations in
               ;; GENERATE-TEMPORARIES.  Be careful about the ellipsis!
               ((k ((?var* ?init*) :::)
                   (?body1* ?body2* :::)
                   ;; Here are the actual arguments to the continuation
                   ;; -- the previous bits of the pattern were just the
                   ;; 'environment' of the continuation --:
                   (?temp :::))
                (let ((?var* (if #f #f)) ; Get an 'unspecific' value.
                      :::)
                  (let ((?temp ?init*) :::)
                    (set! ?var* ?temp) :::
                    (let () ?body1* ?body2* :::)))))))
       (generate-temporaries (?var ...)
         ;; Pass K the environment.  GENERATE-TEMPORARIES will add the
         ;; temporary variable list argument.
         (k ((?var ?init) ...) (?body1 ?body2 ...)))))))

(let ((odd? (lambda x (error "error")))
      (even? (lambda x (error "error")))) 
      (letrec/46 ((odd? (lambda (x)
                          (case x
                            ((0) #f)
                            ((1) #t)
                            (else (even? (- x 1)))))
                        )
                  (even? (lambda (x)
                           (case x
                             ((0) #t)
                             ((1) #f)
                             (else (odd? (- x 1)))))))
                 (display (list 
                            (odd? 1)
                            (even? 1)
                            (odd? 20)
                            (even? 20))))) 


(define-syntax mylist
  (syntax-rules ::: ()
    ((_ ... :::) (list ... :::))))

(display (mylist 1 2 3))(newline)

(case 1
  ((0) => (lambda (f) (error "why?")))
  ((1) => (lambda (g) (display g)(newline)))
  )

(display (string-map (lambda (c) (if (char=? c #\a) #\b c))
                     "BABAbaba"
                     ))(newline)
