package day5

import "core:fmt"
import "core:strings"
import "src:day2"

parse_and_count_ranges_IDs :: proc(
	input: string,
	allocator := context.allocator,
) -> (
	n: int,
	err: day2.Parse_Range_Error,
) {
	s := strings.trim_space(input)

	ls := strings.split_lines(s, allocator)
	defer delete(ls)

	rs := make([dynamic][2]int)
	defer delete(rs)

	for l in ls {
		if l == "" {
			break
		}

		x, y := day2.parse_range(l) or_return
		append(&rs, [2]int{x, y})
	}

	ids := make(map[int]struct{})
	defer delete(ids)

	for r in rs {
		for i in r[0] ..= r[1] {
			fmt.printfln("i %v", i)
			ids[i] = struct{}{}
		}
	}

	return len(ids), nil
}
