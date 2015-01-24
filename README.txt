OOL in lisp

Paradigma object-oriented con ereditarietà singola tra classi

Si definisce una classe con (define-class nome parent [campo valore]* )
dove "nome" e "campo" devono essere simboli, valore può essere una
qualsiasi espressione lisp; in particolare per aggiungere un metodo,
usare '(method (arg1,arg2) (operazione) (operazione)); nella definizione di metodo si può usare la variabile this che contiene l’istanza della classe su cui il metodo viene chiamato
"parent" può essere nil

Si istanzia una classe con (new classe [campo valore]*), dove "campo" è un
attributo della classe che deve esistere.

Si legge un attributo con (get-slot istanza campo).

L'implementazione utilizza per ogni classe 2 hashmap (una per i metodi, una per
i campi).

Ogni istanza contiene un'hash map per gli attributi, mentre si riferisce a
quella della classe "prototipo" per i metodi.

Si richiama un metodo con (nome_metodo istanza_classe [parametri]*) il metodo lavora sui parametri dell’istanza ma utilizza il codice del metodo riportato nel prototipo.

