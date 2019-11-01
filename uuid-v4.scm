(module uuid-v4 (make-uuid)

(import scheme
        (chicken base)
        (chicken random)
        (chicken bitwise)
        srfi-1)

(define (zero-padded-hex x)
  (let* [(s (string-append "0" (number->string (char->integer x) 16)))
         (len (string-length s))]
    (substring s (- len 2) len)))

(define (split-at-tabs lst tabs)
  (if (null? tabs)
      (list lst)
      (let-values [((h r) (split-at lst (car tabs)))]
        (cons h (split-at-tabs r (cdr tabs))))))

(define (make-uuid)
  (let* [(buf (make-string 16))]
    (random-bytes buf)
    ;; set version 4
    (set! (string-ref buf 6) (integer->char (bitwise-ior 64 (bitwise-and 15 (char->integer (string-ref buf 6))))))
    ;; set variant 1
    (set! (string-ref buf 8) (integer->char (bitwise-ior 128 (bitwise-and 63 (char->integer (string-ref buf 8))))))
    (let* [(buf (map zero-padded-hex (string->list buf)))]
      (foldl (lambda (x y) (if x (string-append x "-" y) y)) #f
             (map (lambda (lst)
                    (foldl string-append "" lst))
                  (split-at-tabs buf '(4 2 2 2)))))))

)
