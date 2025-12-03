package main

import "../utils"
import "./part_1"
import "./part_2/"

main :: proc() {
	part_1_test := utils.get_aoc_data("part 1 TEST", "./test_1_input.txt")
	part_1.run(part_1_test)

	part_1_challenge := utils.get_aoc_data("part 1", "./day_1_input.txt")
	part_1.run(part_1_challenge)

	part_2_test := utils.get_aoc_data("part 2 TEST", "./test_1_input.txt")
	part_2.run(part_2_test)

	part_2_challenge := utils.get_aoc_data("part 2", "./day_1_input.txt")
	part_2.run(part_2_challenge)
}
