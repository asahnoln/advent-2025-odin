package day1_test

import "core:slice"
import "core:testing"
import "src:day1"

@(test)
counts_zeroes :: proc(t: ^testing.T) {
	n, err := day1.parse_and_count_zeroes(`
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82`[1:])
	testing.expect(t, err == nil)
	testing.expect_value(t, n, 3)
}

@(test)
turn_dial :: proc(t: ^testing.T) {
	tests := []struct {
		start: int,
		dir:   day1.Direction,
		n:     int,
		want:  int,
	} {
		{50, .Left, 10, 40}, //
		{50, .Right, 10, 60},
		{50, .Left, 60, 90},
		{50, .Right, 60, 10},
	}

	for tt in tests {
		got := day1.turn_dial(tt.start, tt.dir, tt.n)

		testing.expectf(
			t,
			got == tt.want,
			"from %d turn %v %d clicks: got %d, want %d",
			tt.start,
			tt.dir,
			tt.n,
			got,
			tt.want,
		)
	}
}

@(test)
count_zeroes :: proc(t: ^testing.T) {
	got := day1.count_zeroes(
		50,
		{
			{.Left, 50}, // 0
			{.Left, 50}, // 50
			{.Right, 50}, // 0
		},
	)

	testing.expect_value(t, got, 2)
}

@(test)
parse_cmd :: proc(t: ^testing.T) {
	tests := []struct {
		cmd:  string,
		want: day1.Cmd,
	} {
		{"L40", {.Left, 40}}, //
		{"R50", {.Right, 50}},
	}

	for tt in tests {
		got, err := day1.parse_cmd(tt.cmd)
		testing.expectf(t, err == nil, "parsed %q: err %v, want nil", tt.cmd, err)
		testing.expectf(t, got == tt.want, "parsed %q: got %v, want %v", tt.cmd, got, tt.want)
	}
}

@(test)
parse_cmd_err :: proc(t: ^testing.T) {
	tests := []struct {
		cmd:  string,
		want: day1.Parse_Error,
	} {
		{"X40", {d = 'X', msg = "wrong direction"}}, //
		{"Llol", {n = "lol", msg = "wrong count"}}, //
	}

	for tt in tests {
		_, err := day1.parse_cmd(tt.cmd)
		testing.expectf(t, err == tt.want, "parsed %q: got err %v, want %v", tt.cmd, err, tt.want)
	}
}

@(test)
parse_cmds :: proc(t: ^testing.T) {
	tests := []struct {
		input: string,
		want:  []day1.Cmd,
	} {
		{"R50\nL40", {{.Right, 50}, {.Left, 40}}}, //
	}

	for tt in tests {
		got, err := day1.parse_cmds(tt.input)

		testing.expectf(t, err == nil, "parsed %q: err %v, want nil", tt.input, err)
		testing.expectf(
			t,
			slice.equal(got, tt.want),
			"parsed %q: got %v, want %v",
			tt.input,
			got,
			tt.want,
		)
	}
}
