package day1_test

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
