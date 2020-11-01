(module uuid-v4 *

  (import scheme
          (chicken base)
          (chicken random)
		  (chicken irregex))

  (define *regexp* (irregex "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}"))
  
  (define (make-uuid-v4)
	(define (hex-char x) (string-ref (number->string x 16) 0))
	(let ((u (make-string 36)))
	  (do ((i 0 (add1 i)))
		  ((= i 36))
		(set! (string-ref u i)
		  (case i
			((8 13 18 23) #\-)
			((14) #\4) ;; 4-bit version marker
			((19) (hex-char (+ 8 (pseudo-random-integer 4)))) ;; 2-bit variant marker
			(else (hex-char (pseudo-random-integer 16))))))
	  u))

  (define nil-uuid "00000000-0000-0000-0000-000000000000")

  (define (uuid? u)
	(and (string? u)
		 (irregex-match? *regexp* u)))

  (define (uuid-v4? u)
	(and (uuid? u)
		 (eqv? #\4 (string-ref u 14)))))


