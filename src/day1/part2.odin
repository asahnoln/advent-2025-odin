package day1

parse_and_count_zeroes_part2 :: proc(
	s: string,
	allocator := context.allocator,
) -> (
	n: int,
	err: Error,
) {
	cmds: []Cmd
	cmds = parse_cmds(s, allocator) or_return
	defer delete(cmds)

	n = count_zeroes_part2(50, cmds)
	return
}

count_zeroes_part2 :: proc(start: int, turns: []Cmd) -> (n: int) {
	c := start
	for t in turns {
		c = turn_dial(c, t.d, t.c)

		if c == 0 {
			n += 1
		}
	}
	return n
}
