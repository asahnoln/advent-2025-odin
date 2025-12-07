package day6_test

import "core:testing"
import "src:day6"

@(test)
full :: proc(t: ^testing.T) {
	got, err := day6.parse_and_find_sum_of_all_math(
		`
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
`,
	)

	testing.expectf(t, err == nil, "got err %v; want nil", err)
	testing.expect_value(t, got, 4277556)
}

@(test)
apply_math :: proc(t: ^testing.T) {
	tests := []struct {
		nums: []int,
		op:   day6.Op,
		want: int,
	} {
		{{328, 64, 98}, .Plus, 490}, //
		{{123, 45, 6}, .Mul, 33210},
	}

	for tt in tests {
		got := day6.apply_math(tt.op, ..tt.nums)

		testing.expectf(
			t,
			got == tt.want,
			"op %v for %v: got %v; want %v",
			tt.op,
			tt.nums,
			got,
			tt.want,
		)
	}
}

@(test)
char_to_op :: proc(t: ^testing.T) {
	tests := []struct {
		char:    byte,
		want:    day6.Op,
		wantErr: day6.Char_To_Op_Error,
	} {
		{'+', .Plus, nil}, //
		{'*', .Mul, nil},
		{'a', nil, day6.Conversion_Error{input = 'a'}},
	}

	for tt in tests {
		got, err := day6.char_to_op(tt.char)

		testing.expectf(
			t,
			err == tt.wantErr,
			"char %v: got err %v; want %v",
			tt.char,
			err,
			tt.wantErr,
		)
		testing.expectf(t, got == tt.want, "char %v: got %v; want %v", tt.char, got, tt.want)
	}
}
