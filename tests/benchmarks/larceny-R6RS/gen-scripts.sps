;; Still not ported to r7rs-bridge

(import (yuni util files)
        (rnrs))

(define bench (file->sexp-list "benchmarks.scm"))

(define srcdir "src")
(define outdir "scripts")

(define common (file->string-list (path-append srcdir "common.sch")))

(define (mix name)
  (define src (path-append srcdir (string-append name ".sch")))
  (define outname (path-append outdir (string-append name ".sps")))
  (define outfile (append
                    (file->string-list src)
                    common))
  (when (file-exists? outname)
    (delete-file outname))
  (call-with-output-file
    outname
    (lambda (p)
      (for-each (lambda (line)
                  (display line p)
                  (newline p))
                outfile))))

(for-each (lambda (set)
            (for-each (lambda (bench)
                        (when (string? bench)
                          (mix bench)))
                      set))
          bench)



