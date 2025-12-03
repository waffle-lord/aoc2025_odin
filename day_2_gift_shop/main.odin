package main

import "../utils"
import "./part_1"

main :: proc() {
	part_1_test := utils.get_aoc_data("part 1 TEST", "./test_2_input.txt")
	part_1_test.print_verbose = true
	part_1.run(part_1_test)
}
