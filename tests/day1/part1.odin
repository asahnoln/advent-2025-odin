package day1_test

import "core:slice"
import "core:testing"
import "src:day1"

@(test)
parse_and_count_zeroes :: proc(t: ^testing.T) {
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
L82`)
	testing.expect(t, err == nil)
	testing.expect_value(t, n, 3)
}

@(test)
parse_and_count_zeroes_error :: proc(t: ^testing.T) {
	_, err := day1.parse_and_count_zeroes("S U P E R W R O N G")
	testing.expect(t, err != nil)
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
		{" L30 ", {.Left, 30}}, //
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
		want: day1.Parse_Cmd_Error,
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
		{"R5\nL40", {{.Right, 5}, {.Left, 40}}}, //
		{" \n R1 \n L10\n ", {{.Right, 1}, {.Left, 10}}}, //
	}

	for tt in tests {
		got, err := day1.parse_cmds(tt.input)
		defer delete(got)

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

@(test)
parse_cmds_error :: proc(t: ^testing.T) {
	_, err := day1.parse_cmds("L50\nWRONG")

	testing.expect_value(
		t,
		err,
		day1.Parse_Line_Error{n = 1, err = {d = 'W', msg = "wrong direction"}},
	)
}
