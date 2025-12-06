package day3

import "core:slice"
import "core:strconv"
import "core:strings"

Bank_Error :: union {
	Short_Input_Error,
	Not_Number_Error,
}

Short_Input_Error :: struct {
	val: string,
}

Not_Number_Error :: struct {
	val: string,
}

parse_and_find_jolt_sum :: proc(input: string) -> (sum: int, err: Bank_Error) {
	s := strings.trim_space(input)
	ls := strings.split_lines(s)
	defer delete(ls)

	for l in ls {
		sum += max_jolt(l) or_return
	}

	return sum, nil
}

max_jolt :: proc(input: string) -> (int, Bank_Error) {
	if l := len(input); l < 2 {
		return 0, Short_Input_Error{val = input}
	}

	s := transmute([]byte)input

	max1_i := slice.max_index(s[:len(input) - 1])
	after_max1_i := max1_i + 1

	max2_i := slice.max_index(s[after_max1_i:])

	num := string([]byte{input[max1_i], input[after_max1_i + max2_i]})
	n, ok := strconv.parse_int(num)

	if !ok {
		return 0, Not_Number_Error{val = num}
	}

	return n, nil
}
