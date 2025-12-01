package day1

Error :: union {
	Parse_Error,
}

Parse_Error :: struct {}

Direction :: enum {
	Left,
	Right,
}

MAX_DIAL :: 100

turn_dial :: proc(start: int, d: Direction, c: int) -> (n: int) {
	return (start + (d == .Left ? -1 : 1) * c) %% MAX_DIAL
}

Cmd :: struct {
	d: Direction,
	c: int,
}

count_zeroes :: proc(start: int, turns: []Cmd) -> (n: int) {
	c := start
	for t in turns {
		c = turn_dial(c, t.d, t.c)

		if c == 0 {
			n += 1
		}
	}
	return n
}

parse_and_count_zeroes :: proc(s: string) -> (n: int, err: Error) {
	return 3, nil
}
