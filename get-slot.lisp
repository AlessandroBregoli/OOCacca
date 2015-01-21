;controlla che la lista fornita rispetti la specifica (rappresenti un 
; metodo)
(defun methodp (value)
	(and (listp value) (> (length value) 2) (eq 'method (first value)))
)
;a ogni chiamata di metodo trasforma la rappresentazione relativa 
;(method () ())
;in una lambda e la applica
(defun call_method (this nome args)
	(let 
		(
		  (arglist (cons 'this 
		  (second(gethash nome (cdr (get-class-spec (cdr this)))))))
		  (corpofunz (prognizza 
			(rest (rest (gethash nome 
			(cdr (get-class-spec (cdr this))))))))
		)
		(apply (eval (list 'lambda arglist corpofunz))
			(cons this args))
	)
)
;prende una lista di sexp sperando che siano chiamate di funzione e
;le fa diventare gli argomenti di una chiamata a progn
(defun prognizza (operazioni)
	(cons 'progn operazioni)
)

;imposta 
(defun set-slot (classe campo valore)
	(let ((tabella 
		(if (methodp valore) 
			(cdr classe) 
			(car classe)
		)
	     ))
	     (progn
		(if (not (has_member tabella campo))
			(setf (gethash '__names__ tabella) 
			      (cons campo (gethash '__names__ tabella))
			)
		)
		;in ogni caso:
		(setf (gethash campo tabella) valore)
		;se è un metodo serve esportare la funzione
		(if (methodp valore)
			(process-method campo valore)
		)
	     )
	)
)
;installa un metodo.
(defun process-method (method-name metod-spec)
	(setf (fdefinition method-name)
		(lambda (this &rest args)
			(call_method this method-name args)
		)
	)
)
;restituisce un attributo di istanza (non funziona sui metodi)
(defun get-slot (istanza nome) 
	(gethash nome (car istanza))
)
