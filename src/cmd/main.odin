package main

import "core:fmt"
import "core:os"
import "src:day1"
main :: proc() {
	s, err := os.read_entire_file_or_err(os.args[1])
	if err != nil {
		fmt.printfln("error reading file: %v", err)
	}

	n, err2 := day1.parse_and_count_zeroes_part2(string(s))
	if err2 != nil {
		fmt.printfln("error parsing: %v", err2)
	}
	fmt.printfln("answer: %d", n)
}
