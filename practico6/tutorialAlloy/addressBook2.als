module tour/addressBook2
abstract sig Target {}
sig Addr extends Target {}
abstract sig Name extends Target {}

sig Alias, Group extends Name {}
sig Book {
	names: set Name,
	addr: Name -> Target
} {
	no n: Name | n in n.^(addr)
	all a: Alias | lone a.addr
}

pred show (b: Book) {some Alias.(b.addr)}


pred add (b, bp: Book, n: Name, t: Target) {bp.addr = b.addr + n -> t}
pred del (b, bp: Book, n: Name, t: Target) {bp.addr = b.addr - n -> t}
fun lookup (b: Book, n: Name): set Addr {n.^(b.addr) & Addr}


run show for 3 but 1 Book

assert delUndoesAdd {
all b,bp,bpp: Book, n: Name, t: Target |
no n.(b.addr) and
add [b,bp,n,t] and del [bp,bpp,n, t] implies b.addr = bpp.addr
}
check delUndoesAdd for 3
assert addIdempotent {
all b,bp,bpp: Book, n: Name, t: Target |
add [b,bp,n,t] and add [bp,bpp,n,t] implies bp.addr = bpp.addr
}
check addIdempotent for 3
assert addLocal {
all b,bp: Book, n,np: Name, t: Target |
add [b,bp,n,t] and n != np
implies lookup [b,np] = lookup [bp,np]
}
check addLocal for 3 but 2 Book
assert lookupYields {
all b: Book, n: b.names | some lookup [b,n]
}
check lookupYields for 4 but 1 Book
