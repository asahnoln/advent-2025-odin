package day2

import "core:log"
import "core:math"
import "core:strconv"
import "core:strings"

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
sum_of_invalid_IDs :: proc(ranges: string) -> (s: int, err: Parse_Range_Error) {
	s = 1227775554
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

// TODO: finish implementation
find_invalid_IDs :: proc(
	start: int,
	end: int,
	allocator := context.allocator,
) -> (
	ids: []int,
	err: Parse_Range_Error,
) {

	for n in start ..= end {

	}

	ids = make([]int, 2)
	ids[0] = 11
	ids[1] = 22
	return
}

is_invalid_id :: proc(id: int) -> (ok: bool) {
	p := math.count_digits_of_base(id, 10) / 2
	ln := cast(int)math.pow10(cast(f64)p)
	l, r := id / ln, id % ln

	return l == r
}
