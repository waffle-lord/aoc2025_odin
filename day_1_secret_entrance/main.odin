package main

import "../utils"
import "./part_1"

main :: proc() {
	part_1_test := utils.get_aoc_data("part 1 test", "./part_1/test_input.txt")
	part_1_challenge := utils.get_aoc_data("part 1", "./part_1/day_1_part_1_input.txt")

	// part_1_test.print_verbose = true
	// part_1.run(part_1_test)
	part_1.run(part_1_challenge)
}
