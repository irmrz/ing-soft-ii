module tour/addressBook1

sig Name, Addr {}
sig Book {
	addr: Name -> lone Addr
}

pred show (b: Book) {
	#b.addr > 1
	#Name.(b.addr) > 1
}

run show for 3 but 1 Book

pred add (b, bp: Book, n: Name, a: Addr) {
	bp.addr = b.addr + n -> a
}

pred showAdd(b, bp: Book, n: Name, a: Addr) {
	add [b, bp, n, a]
	#Name.(bp.addr) > 1
}

pred del (b, bp: Book, n: Name) {
	bp.addr = b.addr - n -> Addr
}

fun lookup (b: Book, n: Name): set Addr {
	n.(b.addr)
}

run showAdd for 3 but 2 Book

assert delUndoesAdd {
	all b, bp, bpp: Book, n: Name, a: Addr |
	no n.(b.addr) and
	add[b,bp,n,a] and 
	del [bp,bpp,n] 
	implies b.addr = bpp.addr
}

assert addIdempotent {
all b,bp,bpp: Book, n: Name, a: Addr |
add [b,bp,n,a] and add [bp,bpp,n,a] implies bp.addr = bpp.addr
}

assert addLocal {
all b,bp: Book, n,np: Name, a: Addr |
add [b,bp,n,a] and n != np implies lookup [b,np] = lookup [bp,np]
}

check delUndoesAdd for 10 but 3 Book
check addIdempotent for 3
check addLocal for 3 but 2 Book


