package day3_test

import "core:testing"
import "src:day3"

// TODO: Finish full
@(test)
full :: proc(t: ^testing.T) {
	got, err := day3.parse_and_find_jolt_sum(
		`
987654321111111
811111111111119
234234234234278
818181911112111
`,
	)

	testing.expectf(t, err == nil, "got err %v; want nil", err)
	testing.expect_value(t, got, 357)
}

@(test)
max_jolt :: proc(t: ^testing.T) {
	tests := []struct {
		input: string,
		want:  int,
	} {
		{"12", 12}, //
		{"123", 23},
		{"1214", 24},
		{"121412", 42},
		{"987654321111111", 98},
		{"811111111111119", 89},
		{"234234234234278", 78},
		{"818181911112111", 92},
	}

	for tt in tests {
		got, err := day3.max_jolt(tt.input)

		testing.expect(t, err == nil, "got err %v; want nil")
		testing.expectf(t, got == tt.want, "input %q: got %v; want %v", tt.input, got, tt.want)
	}
}

@(test)
max_jolt_error :: proc(t: ^testing.T) {
	tests := []struct {
		input: string,
		err:   day3.Bank_Error,
	} {
		{"", day3.Short_Input_Error{val = ""}}, //
		{"1", day3.Short_Input_Error{val = "1"}}, //
		// TODO: Cant find a way to properly test it
		// {"1a2x", day3.Not_Number_Error{val = "\x1d\x00"}}, //
	}

	for tt in tests {
		_, err := day3.max_jolt(tt.input)

		testing.expectf(t, err == tt.err, "input %q: got err %v; want %v", tt.input, err, tt.err)
	}
}
