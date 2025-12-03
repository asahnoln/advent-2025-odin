package day2

import "core:log"
import "core:math"
import "core:slice"
import "core:strconv"
import "core:strings"

Find_Range_Error :: enum {
	None,
	Start_Is_Bigger_Than_End,
}

Parse_Range_Error :: union {
	Dash_Not_Found_Error,
	Parse_Number_Error,
}

Dash_Not_Found_Error :: struct {
	val: string,
}

Number_Pos :: enum {
	First,
	Second,
}

Parse_Number_Error :: struct {
	pos: Number_Pos,
	val: string,
}

// TODO: More detailed error
sum_of_invalid_IDs :: proc(
	ranges: string,
	allocator := context.allocator,
) -> (
	s: int,
	err: Parse_Range_Error,
) {
	rs := strings.split(ranges, ",", allocator)
	defer delete(rs)

	all := make([dynamic]int)
	defer delete(all)

	for r in rs {
		x, y := parse_range(r) or_return
		ids := find_invalid_IDs(x, y)
		defer delete(ids)

		append(&all, ..ids)
	}

	s = math.sum(all[:])

	return
}

parse_range :: proc(range: string) -> (x: int, y: int, err: Parse_Range_Error) {
	dash_i := strings.index_rune(range, '-')
	if dash_i == -1 {
		return x, y, Dash_Not_Found_Error{val = range}
	}

	x = parse_number(range[:dash_i], .First) or_return
	y = parse_number(range[dash_i + 1:], .Second) or_return

	return x, y, nil
}

@(private)
parse_number :: proc(val: string, pos: Number_Pos) -> (int, Parse_Range_Error) {
	n, ok := strconv.parse_int(val)
	if !ok {
		return n, Parse_Number_Error{pos = pos, val = val}
	}

	return n, nil
}

find_invalid_IDs :: proc(start: int, end: int, allocator := context.allocator) -> []int {
	ids := make([dynamic]int, allocator)
	for n in start ..= end {
		if is_invalid_id(n) {
			append(&ids, n)
		}
	}

	return ids[:]
}

is_invalid_id :: proc(id: int) -> (ok: bool) {
	p := math.count_digits_of_base(id, 10) / 2
	ln := cast(int)math.pow10(cast(f64)p)
	l, r := id / ln, id % ln

	return l == r
}
