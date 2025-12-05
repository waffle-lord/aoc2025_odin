package main

import "../utils"
import "./part_1"
import "./part_2/"
import "core:fmt"
import "core:testing"

@(test)
part_1_test :: proc(t: ^testing.T) {
	expected_answer := 3
	test_input := utils.get_aoc_data("part 1 TEST", "./test_1_input.txt")
	answer := part_1.run(test_input)

	testing.expect(
		t,
		answer == expected_answer,
		fmt.aprint("answer", answer, "not equal", expected_answer),
	)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
	expected_answer := 6
	test_input := utils.get_aoc_data("part 2 TEST", "./test_1_input.txt")
	answer := part_2.run(test_input)

	testing.expect(
		t,
		answer == expected_answer,
		fmt.aprint("answer", answer, "not equal", expected_answer),
	)
}

main :: proc() {

	part_1_challenge := utils.get_aoc_data("part 1", "./day_1_input.txt")
	part_1.run(part_1_challenge)


	part_2_challenge := utils.get_aoc_data("part 2", "./day_1_input.txt")
	part_2.run(part_2_challenge)
}
