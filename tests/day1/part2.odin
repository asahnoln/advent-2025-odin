package day1_test

import "core:testing"
import "src:day1"

@(test)
parse_and_count_zeroes_part2 :: proc(t: ^testing.T) {
	n, err := day1.parse_and_count_zeroes_part2(`
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
	testing.expect_value(t, n, 6)
}
