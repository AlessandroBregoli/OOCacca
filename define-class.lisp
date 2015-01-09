(defun define-class (name parent &rest coppie)
	(if (not (and 
		(check_name name)
		(check_parent parent) 
		(check_args coppie)
		(class_not_exists name)
		))
		(error "")
		
		
		(progn
			(add-class-spec name (init_hmaps parent))
			(init-slots (get-class-spec name) coppie)
			name
		)
	)
)

(defun init-slots (classe coppie &optional (is_istance nil))
	(if (null coppie)
		T
	;else
		(progn 
			(if (and is_istance (not (has_member (car classe) (first coppie))))
				(error "Attributo ~s non trovato" (first coppie))
			)
			(set-slot classe (first coppie) (second coppie))
			(init-slots classe (rest (rest coppie)))
		)
	)
)

	
(defun check_args (args)
	(if (and 
		(evenp (length args))
		(check_ids args)
	) T
	(progn (format t "Argomenti non validi. ~%") nil)
	)
)

(defun check_ids (args)
	(cond 
		((null args) t)
		((check_name (first args)) (check_ids (rest (rest args))))
		(t nil)
	)
)

(defun check_name (name)
	(if (and 
		(not (null name))
		(not (numberp name))
		(not (eq name '__names__))
		(atom name)
	) t 
		(progn (format t "~%Nome ~s non valido. " name) nil)
	)
)

(defun check_parent (parent) 
	(or (null parent) (get-class-spec parent) 
		(format t "parent ~s non esistente" parent))
)	

(defun class_not_exists (name)
	(not (and (get-class-spec name) (not (format t 
					"classe ~s esistente" name))))
)

