package day5_test

import "core:testing"
import "src:day5"

@(test)
full :: proc(t: ^testing.T) {
	got, err := day5.parse_and_count_fresh_IDs(`
3-5
10-14
16-20
12-18

1
5
8
11
17
32`)

	testing.expectf(t, err == nil, "got err %v; want nil", err)
	testing.expect_value(t, got, 3)
}

@(test)
is_fresh :: proc(t: ^testing.T) {
	tests := []struct {
		range: [2]int,
		id:    int,
		want:  bool,
	} {
		{{3, 5}, 1, false}, //
		{{3, 5}, 5, true},
	}

	for tt in tests {
		got := day5.is_fresh(tt.id, tt.range[0], tt.range[1])

		testing.expectf(
			t,
			got == tt.want,
			"ID %d in range %v: got %v; want %v",
			tt.id,
			tt.range,
			got,
			tt.want,
		)
	}
}

// parse_ids :: proc(t: ^testing.T) {
// 	got, err := day5.parse_ints(`
// 1
// 5
// 8
// 11
// 17
// 32`)
//
// 	testing.expectf(t, err == nil, "got err %v; want nil", err)
// 	testing.expect_value(t, got, []int{1, 5, 8, 11, 17, 32})
// }
