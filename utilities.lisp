(defparameter *classes-specs* (make-hash-table))

(defun add-class-spec (name class-spec)
	(setf (gethash name *classes-specs*) class-spec))
(defun get-class-spec (name)
	(gethash name *classes-specs*))

(defun deep_copy (table1 table2)
	(mapcar (lambda (name) 
		(setf (gethash name table2) 
			(gethash name table1))) 
		(gethash '__names__ table1)
	)
)
