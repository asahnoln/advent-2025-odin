package day2_test

import "core:slice"
import "core:testing"
import "src:day2"

@(test)
// TODO: Finish implementation
full_test :: proc(t: ^testing.T) {
	s, err := day2.sum_of_invalid_IDs(
		`11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124`,
	)

	testing.expectf(t, err == nil, "got err %v; want nil", err)
	testing.expect_value(t, s, 1227775554)
}

@(test)
parse_range :: proc(t: ^testing.T) {
	tests := []struct {
		range:        string,
		wantX, wantY: int,
	} {
		{"11-22", 11, 22}, //
		{"1-8674", 1, 8674}, //
	}

	for tt in tests {
		x, y, err := day2.parse_range(tt.range)
		testing.expectf(t, err == nil, "parse %q: got err %v; want nil", err)
		testing.expectf(
			t,
			x == tt.wantX,
			"parse %q: got range start %d; want %d",
			tt.range,
			x,
			tt.wantX,
		)
		testing.expectf(
			t,
			y == tt.wantY,
			"parse %q: got range end %d; want %d",
			tt.range,
			y,
			tt.wantY,
		)
	}

}

@(test)
parse_range_error :: proc(t: ^testing.T) {
	tests := []struct {
		input: string,
		err:   day2.Parse_Range_Error,
	} {
		{"lol", day2.Dash_Not_Found_Error{val = "lol"}}, //
		{"-", day2.Parse_Number_Error{pos = .First, val = ""}},
		{"11112-xxx", day2.Parse_Number_Error{pos = .Second, val = "xxx"}},
	}

	for tt in tests {
		_, _, err := day2.parse_range(tt.input)
		testing.expectf(t, err == tt.err, "parse %q: got err %v; want %v", tt.input, err, tt.err)
	}

}

@(test)
find_invalid_IDs :: proc(t: ^testing.T) {
	tests := []struct {
		start, end: int,
		want:       []int,
	} {
		{11, 22, {11, 22}}, //
	}

	for tt in tests {
		got := day2.find_invalid_IDs(tt.start, tt.end)
		defer delete(got)

		testing.expectf(
			t,
			slice.equal(got, tt.want),
			"range %d-%d: got %v; want %v",
			tt.start,
			tt.end,
			got,
			tt.want,
		)
	}
}

@(test)
is_invalid_id :: proc(t: ^testing.T) {
	tests := []struct {
		x:    int,
		want: bool,
	} {
		{1, false}, //
		{11, true},
		{123123, true},
	}

	for i in tests {
		got := day2.is_invalid_id(i.x)
		testing.expectf(t, got == i.want, "check_id(%d): got %v; want %v", i.x, got, i.want)
	}
}
