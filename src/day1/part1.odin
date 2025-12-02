package day1

import "core:math"
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

// turn_dial returns new n after turning from start position c times in given direction.
// It returns how many times dial crossed zero as z
turn_dial :: proc(start: int, d: Direction, c: int) -> (n: int, z: int) {
	x := start + (d == .Left ? -1 : 1) * c

	// TODO: Can I find a better math solution?
	if x <= 0 && start != 0 {
		z = 1
	}
	if x <= 0 || x >= MAX_DIAL {
		z += x / MAX_DIAL
	}

	return x %% MAX_DIAL, z
}

count_zeroes :: proc(start: int, turns: []Cmd) -> (n: int, z: int) {
	c := start
	cz := 0
	for t in turns {
		c, cz = turn_dial(c, t.d, t.c)

		z += cz
		if c == 0 {
			n += 1
		}
	}
	return n, z
}

parse_cmd :: proc(s: string) -> (c: Cmd, err: Error) {
	str := strings.trim_space(s)

	dir: Direction = .Left
	switch d := utf8.rune_at_pos(str, 0); d {
	case 'L':
		dir = .Left
	case 'R':
		dir = .Right
	case:
		return c, Parse_Cmd_Error{d = d, msg = "wrong direction"}
	}

	n := str[1:]
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

	n, _ = count_zeroes(50, cmds)
	return
}
