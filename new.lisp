;new restituisce un'instanza della classe clname inizializzata con i valori
;forniti o, per i membri assenti, i valori di default della classe.
(defun new (clname &rest coppie) 
	(let ((attributi (make-hash-table))
	      (prototipo (get-class-spec clname))
	     )
	     (progn 
		(or (check_args coppie) (error ""))
		;copia classe originale
		(deep_copy (car prototipo) attributi)
		;sovrascrivi i campi passati
		(init-slots (cons attributi clname) coppie T)
		(cons attributi clname)
	     )
	)
)
