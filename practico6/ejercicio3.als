sig Addr, Data {}

sig Memory {
	addrs: set Addr,
	map: addrs -> one Data
} {
	~map.map in iden
	map.Data = addrs
}

sig MainMemory extends Memory { }

sig Cache extends Memory {
	dirty: set addrs
}

sig System {
	cache: Cache,
	main: MainMemory
}

pred Write [m_i, m_o: Memory, d: Data, a: Addr] {
	m_o.map = m_i.map ++ (a -> d)
}

pred read [ m: Memory, a: Addr, d_o: Data ] {
    let d= m.map[a] | some d implies d = d_o
}

assert {
	all s: System |
		all a: s.cache.addrs-s.cache.dirty |
			s.cache.map[a] = s.main.map[a]
}

pred Consistent [s:System] {
	s.cache.map - (s.cache.dirty -> Data) in s.main.map
}

pred Flush [s: System] {
	all a: s.cache.dirty | // estos son direcciones de memoria
		s.main.map = s.main.map ++ (a ->s.cache.map[a])
	s.cache.dirty = none
}

pred initDirty [s: System, a: Addr, d: Data] {
	s.cache.map[a] = d
	a in s.cache.dirty
}

assert FlushWorks {
	all sys: System, a: Addr, d: Data |
		initDirty[sys,a,d] and Flush[sys] implies sys.main.map[a] = d
}

check FlushWorks for 10

