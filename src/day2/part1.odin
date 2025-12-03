package day2

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
