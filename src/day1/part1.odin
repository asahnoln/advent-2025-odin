package day1

import "core:strconv"
import "core:strings"
import "core:unicode/utf8"

Error :: union {
	Parse_Cmd_Error,
	Parse_Line_Error,
}

Parse_Cmd_Error :: struct {
	d:   rune,
	n:   string,
	msg: string,
}

Parse_Line_Error :: struct {
	n:   int,
	err: Parse_Cmd_Error,
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
	s := strings.trim_space(s)

	dir: Direction = .Left
	switch d := utf8.rune_at_pos(s, 0); d {
	case 'L':
		dir = .Left
	case 'R':
		dir = .Right
	case:
		return c, Parse_Cmd_Error{d = d, msg = "wrong direction"}
	}

	n := s[1:]
	x, ok := strconv.parse_int(n, 10)
	if !ok {
		return c, Parse_Cmd_Error{n = n, msg = "wrong count"}
	}

	return {dir, x}, nil
}

parse_cmds :: proc(s: string, allocator := context.allocator) -> (cmds: []Cmd, err: Error) {
	ls := strings.split_lines(strings.trim_space(s), allocator)
	defer delete(ls)

	cmds = make([]Cmd, len(ls))
	for l, i in ls {
		cmds[i], err = parse_cmd(l)
		if err != nil {
			delete(cmds)
			return cmds, Parse_Line_Error{i, err.(Parse_Cmd_Error)}
		}
	}

	return cmds, nil
}

parse_and_count_zeroes :: proc(s: string, allocator := context.allocator) -> (n: int, err: Error) {
	cmds: []Cmd
	cmds = parse_cmds(s, allocator) or_return
	defer delete(cmds)

	n = count_zeroes(50, cmds)
	return
}
