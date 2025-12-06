package main

import "core:fmt"
import "core:os"
import "src:day4"

main :: proc() {
	s, err := os.read_entire_file_or_err(os.args[1])
	if err != nil {
		fmt.panicf("error reading file: %v", err)
	}

	n, err2 := day4.count_accessible_paper_rolls(string(s))
	// n, err2 := day3.parse_and_find_jolt_sum(string(s))
	if err2 != nil {
		fmt.panicf("error parsing: %v", err2)
	}

	fmt.printfln("answer: %d", n)
}
