(defun define-class (name parent &rest coppie)
	(if (not (and 
		(check_name name) 
		(check_parent parent) 
		(check_args coppie)
		(class_not_exists parent)
		))
		(error "")
	(
		
	)
	)
)

