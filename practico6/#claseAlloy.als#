sig Addr {}
sig Data {}
sig Memory {
	addrs: set Addr
	map: Addr -> one Data
}
sig MainMemory extends Memory {}
sig Cache extends Memory {
	dirty: set addrs
}
sig System {
	cache: Cache
	main: MainMemory
}
pred Write [m_i, m_o: Memory, d: Data, a: Addr] {
	m_o.map = m_i.map ++ (a -> d)
}
fact {
	all s: System | s.cache.addrs in s.main.addrs
}
assert {
	all s: System |
		all a: s.cache.addrs-s.cache.dirty |
		     s.cache.map[a] = s.main.map[a]
}
