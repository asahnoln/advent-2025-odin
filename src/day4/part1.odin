package day4

import "core:strings"

MAX_ADJACENT_ROLLS :: 3

count_accessible_paper_rolls :: proc(input: string) -> int {
	s := strings.trim_space(input)
	n := 0
	line_len := strings.index_byte(s, '\n')

	for i in 0 ..< len(s) {
		switch s[i] {
		case '\n', '.':
			continue
		}

		n += cast(int)is_accessible(s, i, line_len)
	}

	return n
}

is_accessible :: proc(s: string, cur_i: int, line_len: int) -> bool {
	c := 0

	if cur_i > 0 {
		c += cast(int)(s[cur_i - 1] == '@')
	}
	if cur_i + 1 < len(s) {
		c += cast(int)(s[cur_i + 1] == '@')
	}

	// TODO: outfactor 3 (len of line)
	lower_i := cur_i + line_len + 1
	if lower_i < len(s) {
		c += cast(int)(s[lower_i - 1] == '@')
		c += cast(int)(s[lower_i] == '@')

		if lower_i + 1 < len(s) {
			c += cast(int)(s[lower_i + 1] == '@')
		}
	}

	upper_i := cur_i - line_len - 1
	if upper_i >= 0 {
		if upper_i - 1 >= 0 {
			c += cast(int)(s[upper_i - 1] == '@')
		}

		c += cast(int)(s[upper_i] == '@')
		c += cast(int)(s[upper_i + 1] == '@')
	}

	return c <= MAX_ADJACENT_ROLLS
}
