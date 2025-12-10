package part1

import "../../utils"
import "../local_utils"
import "core:fmt"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"

run :: proc(aoc: utils.aoc_data) -> int {
	acc := 0

	data := string(aoc.data)
	defer delete(data)

	it := strings.split_lines(data)
	defer delete(it)

	for line, i in &it {
		left := -1
		right := -1

		num := local_utils.get_number(line, 0)

		// set initial left value to first number
		left = num
		utils.print_message(aoc, "Starting @", left, "|", right, debug = true)

		total := len(line)
		point := 1

		for point <= total {
			current := local_utils.get_number(line, point)
			next := local_utils.get_number(line, point + 1)

			utils.print_message(aoc, "line", i, "current:", current, "next:", next, debug = true)
			utils.print_message(aoc, "LR ::", left, "|", right, debug = true)

			if next != -1 && current > left {
				utils.print_message(aoc, "LEFT_UPDATED:", left, "->", current, debug = true)
				left = current
				right = -1
			} else if current > right {
				utils.print_message(aoc, "RIGHT_UPDATED:", right, "->", current, debug = true)
				right = current
			}

			point += 1
		}

		highest := left * 10 + right

		if highest > 0 {
			utils.print_message(aoc, "highest found:", highest, "on line:", i)
			acc += highest
		}
	}

	utils.print_message(aoc, "answer:", acc)
	return acc
}
