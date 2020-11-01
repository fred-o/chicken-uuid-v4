(import srfi-64
		uuid-v4)

(test-begin "uuid-v4")

(test-eqv #f (uuid? '()))
(test-eqv #f (uuid? 23))
(test-eqv #f (uuid? "abc"))
(test-eqv #t (uuid? "75442486-0878-440c-9db1-a7006c25a39f"))

(test-eqv "actual uuid-v4" #t (uuid-v4? "75442486-0878-440c-9db1-a7006c25a39f"))
(test-eqv "wrong version" #f (uuid-v4? "75442486-0878-040c-9db1-a7006c25a39f"))

(test-eqv "make-uuid-v4" #t (uuid-v4? (make-uuid-v4)))

(test-end "uuid-v4")
