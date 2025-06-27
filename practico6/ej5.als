// (a) un preorden
// Los preordenes satisfacen reflexividad y transitividad

sig Elem {}

sig PreOrden {
	order: Elem -> Elem
}{
	all e: Elem | e in e.order // Reflex
	^order in order	      // Transitividad
}

/*
run pre {
	some PreOrden
	#Elem > 2
} for 5 but 1 PreOrden
*/

// (b) Orden Parcial

sig OrdenParcial {
	order: Elem -> Elem
}{
	all e: Elem | e in e.order
	^order in order
	all a,b: Elem | 
		b in a.order and 
		a in b.order implies 
		a = b
}

/*
run parcial {
	some OrdenParcial
	#Elem > 2
} for 5 but 1 OrdenParcial
*/

// (c) Orden total


sig OrdenTotal {
	order: Elem -> Elem
}{
	all e: Elem | e in e.order
	^order in order
	all a,b: Elem | 
		b in a.order and 
		a in b.order implies 
		a = b
	all a,b: Elem |
		a in b.order or
		b in a.order
}

assert totalidad {
	all ot: OrdenTotal |
		all e1, e2: Elem |
			e1 -> e2 in ot.order or
			e2 -> e1 in ot.order
}
/*
check totalidad for 5

run total {
	some OrdenTotal
	#Elem > 2
} for 10 but 1 OrdenParcial
*/

// (d) Orden Estricto
