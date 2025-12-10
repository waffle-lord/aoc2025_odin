package part2

import "../../utils"
import "../local_utils"
import "core:strings"


run :: proc(aoc: utils.aoc_data) -> int {
	acc := 0

	data := string(aoc.data)
	defer delete(data)

	it := strings.split_lines(data)
	defer delete(it)

	for line in &it {
		// TODO: track 12 digit array of highest values from left to right
	}


	return acc
}
