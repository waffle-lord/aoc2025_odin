package main

import "../utils"
import "./part_1"
import "core:fmt"
import "core:testing"

@(test)
part_1_test :: proc(t: ^testing.T) {
	expected_answer := u64(1227775554)
	input_file := utils.get_aoc_data("part 1 TEST", "./test_2_input.txt")
	answer := part_1.run(input_file)

	testing.expect(
		t,
		answer == expected_answer,
		fmt.aprint("answer", answer, "is not equal", expected_answer),
	)
}

main :: proc() {

}
