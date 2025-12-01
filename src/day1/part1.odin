package day1

import "core:fmt"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"

Error :: union {
	Parse_Error,
}

Parse_Error :: struct {
	d:   rune,
	n:   string,
	msg: string,
}

Direction :: enum {
	Left,
	Right,
}

Cmd :: struct {
	d: Direction,
	c: int,
}

MAX_DIAL :: 100

turn_dial :: proc(start: int, d: Direction, c: int) -> (n: int) {
	return (start + (d == .Left ? -1 : 1) * c) %% MAX_DIAL
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

parse_cmd :: proc(s: string) -> (c: Cmd, err: Error) {
	dir: Direction = .Left
	switch d := utf8.rune_at_pos(s, 0); d {
	case 'L':
		dir = .Left
	case 'R':
		dir = .Right
	case:
		return c, Parse_Error{d = d, msg = "wrong direction"}
	}

	n := s[1:]
	x, ok := strconv.parse_int(n, 10)
	if !ok {
		return c, Parse_Error{n = n, msg = "wrong count"}
	}

	return {dir, x}, nil
}

parse_cmds :: proc(s: string, allocator := context.allocator) -> (cs: []Cmd, err: Error) {
	cs = make([]Cmd, 2, allocator)
	cs = {{.Right, 50}, {.Left, 40}}
	return cs, nil
}

parse_and_count_zeroes :: proc(s: string) -> (n: int, err: Error) {
	return 3, nil
}
