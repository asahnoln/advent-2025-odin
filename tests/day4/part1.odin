package day4_test

import "core:testing"
import "src:day4"

@(test)
full :: proc(t: ^testing.T) {
	got := day4.count_accessible_paper_rolls(
		`
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.`,
	)

	testing.expect_value(t, got, 13)
}

@(test)
count_accessible_paper_rolls :: proc(t: ^testing.T) {
	tests := []struct {
		input: string,
		want:  int,
	} {


		// {`@`, 1}, //
		{`
@@@
@.@`, 4},
		{`
...
.@.
...`, 1},
		{`
@@@@
@@@@
....`, 4},
		// TODO: Work out empty spaces
		// {`
		//   ...
		//   .@.
		//   ...`, 1},
	}

	for tt in tests {
		got := day4.count_accessible_paper_rolls(tt.input)
		testing.expectf(t, got == tt.want, "input %q: got %d; want %d", tt.input, got, tt.want)
	}
}

// @(test)
// is_accessible :: proc(t: ^testing.T) {
// 	got := day4.is_accessible(`
// ...
// .@.
// ...`, 7)
// 	testing.expectf(t, got, "got %v; want %v", got, true)
// }
