
;gestione di class-spec come suggerito dalla specifica
(defparameter *classes-specs* (make-hash-table))

(defun add-class-spec (name class-spec)
	(setf (gethash name *classes-specs*) class-spec))
(defun get-class-spec (name)
	(gethash name *classes-specs*))

;deep_copy copia i valori tra due hashmap; l'hash map di origine
;deve contenere la lista __names__ perché ciò funzioni.
(defun deep_copy (table1 table2)
	(mapcar (lambda (name) 
		(setf (gethash name table2) 
			(gethash name table1))) 
		(gethash '__names__ table1)
	)
)

;crea la lista __names__ che tiene traccia dei membri delle hashmap
(defun init_names_list (hmap)
	(progn	(setf (gethash '__names__ hmap) '(__names__)))
		 hmap)

;inizializza la lista dei nomi dei membri dell'hashmap
(defun init_hmaps (parent) 
	(let	((attributi (make-hash-table))
		(metodi (make-hash-table)))
		(if (null parent)
			(cons (init_names_list attributi) 
			(init_names_list metodi))
		;else
			(progn (deep_copy (car (get-class-spec parent)) 
					attributi)
			       (deep_copy (cdr (get-class-spec parent))
					metodi)
			       (cons attributi metodi)
			)
		)
	)
)
;controlla se hashmap ha un membro, tramite lista __names__
;(quindi funziona anche se un membro è impostato a nil)
(defun has_member (hmap memname)
	(member memname (gethash '__names__ hmap))
)
