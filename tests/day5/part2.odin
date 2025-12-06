package day5_test

import "core:testing"
import "src:day5"

@(test)
full2 :: proc(t: ^testing.T) {
	got, err := day5.parse_and_count_ranges_IDs(`
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
	testing.expect_value(t, got, 14)
}
