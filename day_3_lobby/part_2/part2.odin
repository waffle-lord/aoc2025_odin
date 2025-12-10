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

	for line, li in &it {
		// reverse array so we only need to push indexes "up" the array
		r_line := strings.reverse(line)
		defer delete(r_line)

		// setup the first 12 index in the line as our starting indexes
		arr: [12]int

		for i in 0 ..< 12 {
			arr[i] = i
		}

		// starting at 12 (13th element) to begin checking after our initial index setup
		point := 12

		for point != -1 {
			// TODO: check if last index in arr can be moved up to the last highest value in the line.
			// Do this until no higher value numbers are found and collect the arr values
			// join, reverse and convert to int. Add to acc
			r := rune(r_line[point])
		}

	}


	return acc
}
