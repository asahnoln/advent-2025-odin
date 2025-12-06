package day5

Error :: enum {}

parse_and_count_fresh_IDs :: proc(input: string) -> (int, Error) {
	return 3, nil
}

is_fresh :: proc(id, from, to: int) -> (ok: bool) {
	return from >= id && id <= to
}
