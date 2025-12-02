package day1

parse_and_count_zeroes_part2 :: proc(
	s: string,
	allocator := context.allocator,
) -> (
	n: int,
	err: Error,
) {
	return parse_and_count_zeroes_base(s, proc(n, z: int) -> int {
			return z
		}, allocator)
}
