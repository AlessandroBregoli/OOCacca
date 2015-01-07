;(define-class ’person nil ’name "Eve" ’age "undefined")

; (define-class ’student ’person
;	’name "Eva Lu Ator"
	;’university "Berkeley"
	;’talk ’(method ()
		;(princ "My name is ")
		;(princ (get-slot this ’name))
		;(terpri)
		;(princ "My age is ")
		;(princ (get-slot this ’age))))
(assert (not (check_args '(1 2 3))))
(assert (not (check_args '(1 2))))
(assert (not (check_args '(a ciao 123 bhu))))
(assert (check_args '(ciao 5)))
(assert (check_args '()))
(assert (not (check_parent 'nonesiste)))
(add-class-spec 'nonesiste '(nonesiste () ()))
(assert (check_parent 'nonesiste))
(assert (check_parent nil))
