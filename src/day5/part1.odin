package day5

import "core:strconv"
import "core:strings"
import "src:day2"

Error :: union {
	day2.Parse_Range_Error,
}

parse_and_count_fresh_IDs :: proc(
	input: string,
	allocator := context.allocator,
) -> (
	n: int,
	err: Error,
) {
	s := strings.trim_space(input)

	ls := strings.split_lines(s, allocator)
	defer delete(ls)

	rs := make([dynamic][2]int)
	defer delete(rs)

	i := 0
	for l in ls {
		if l == "" {
			break
		}

		x, y := day2.parse_range(l) or_return
		append(&rs, [2]int{x, y})

		i += 1
	}

	for l in ls[i + 1:] {
		x, _ := strconv.parse_int(l)

		for r in rs {
			if is_fresh(x, r[0], r[1]) {
				n += 1
				break
			}
		}
	}

	return n, nil
}

is_fresh :: proc(id, from, to: int) -> (ok: bool) {
	return from <= id && id <= to
}
