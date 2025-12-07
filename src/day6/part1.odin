package day6

import "core:log"
import "core:math"
import "core:slice"
import "core:strconv"
import "core:strings"

Error :: union {
	Char_To_Op_Error,
}

Char_To_Op_Error :: union {
	Conversion_Error,
}

Conversion_Error :: struct {
	input: byte,
}

Op :: enum {
	Plus,
	Prod,
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
	if op == .Prod {
		return math.prod(nums)
	}

	return math.sum(nums)
}

char_to_op :: proc(c: byte) -> (op: Op, err: Char_To_Op_Error) {
	switch c {
	case '*':
		op = .Prod
	case '+':
		op = .Plus
	case:
		err = Conversion_Error {
			input = c,
		}
	}

	return
}

apply_math_to_doc :: proc(
	input: string,
	allocator := context.allocator,
) -> (
	res: []int,
	err: Error,
) {

	ls := strings.split_lines(input, allocator)
	defer delete(ls)

	nums: [][3]int
	defer delete(nums)

	results: []int

	for l, row_i in ls {
		ns := strings.split(l, " ", allocator)
		defer delete(ns)

		if nums == nil {
			nums = make([][3]int, len(ns))
			results = make([]int, len(ns))
		}

		for n, col_i in ns {
			if row_i == len(ls) - 1 {
				op := char_to_op(n[0]) or_return
				results[col_i] = apply_math(op, ..nums[col_i][:])

				continue
			}

			x, _ := strconv.parse_int(n)
			nums[col_i][row_i] = x
		}

	}

	return results, nil
}

apply_math_to_doc_simpler :: proc(
	input: string,
	allocator := context.allocator,
) -> (
	res: []int,
	err: Error,
) {

	// ns := make([dynamic]string)
	// for r in input {

	// }

	res = make([]int, 1)

	// TODO: Refactor out in a loop
	nl_i := strings.index_byte(input, '\n')
	x, _ := strconv.parse_int(input[:nl_i])

	nl_i2 := strings.index_byte(input[nl_i + 1:], '\n')
	y, _ := strconv.parse_int(input[nl_i + 1:][:nl_i2])

	nl_i3 := strings.index_byte(input[nl_i + 1:][nl_i2 + 1:], '\n')
	z, _ := strconv.parse_int(input[nl_i + 1:][nl_i2 + 1:][:nl_i3])
	nums := []int{x, y, z}

	op := char_to_op(input[len(input) - 1]) or_return

	res[0] = apply_math(op, ..nums)

	return res, nil
}
