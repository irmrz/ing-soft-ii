// Grafos dirigidos
// Puede haber nodos desconectados
sig Nodo {}

sig Grafo {
	nodos: set Nodo,
	aristas: nodos -> nodos
}{
	no iden & aristas
}

// (a) El grafo es aciclico

assert NoCycle {
	all g: Grafo |
		no n: g.nodos  |
			n in n.^(g.aristas)
}
		
		
//check NoCycle for 3 but 1 Grafo

// (b)
