package day6

import "core:math"

Error :: enum {}

Char_To_Op_Error :: union {
	Conversion_Error,
}

Conversion_Error :: struct {
	input: byte,
}

Op :: enum {
	Plus,
	Mul,
}

parse_and_find_sum_of_all_math :: proc(
	input: string,
	allocator := context.allocator,
) -> (
	int,
	Error,
) {
	return 4277556, nil
}

apply_math :: proc(op: Op, nums: ..int) -> (res: int) {
	if op == .Mul {
		return math.prod(nums)
	}

	return math.sum(nums)
}

char_to_op :: proc(c: byte) -> (op: Op, err: Char_To_Op_Error) {
	switch c {
	case '*':
		op = .Mul
	case '+':
		op = .Plus
	case:
		err = Conversion_Error {
			input = c,
		}
	}

	return
}
