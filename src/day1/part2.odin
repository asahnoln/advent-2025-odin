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

	_, n = count_zeroes(50, cmds)
	return
}
