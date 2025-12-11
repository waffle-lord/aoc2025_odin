package part2

import "../../utils"
import "../local_utils"
import "core:fmt"
import "core:strings"

some_value :: struct {
	value: int,
	index: int,
}

get_largest :: proc(line: string, start: int, end: int, closest: bool = true) -> some_value {

	largest := some_value {
		value = -1,
		index = -1,
	}

	for i in start ..= end {
		num := local_utils.get_number(line, i)
		if num > largest.value {
			largest.value = num
			largest.index = i
		} else if num == largest.value {
			if closest {
				// get number closer to our bias index (end of range)
				if (end - largest.index) > (end - i) {
					largest.value = num
					largest.index = i
				}
			} else {
				// get number farther from our bias index (start of range)
				if (largest.index - start) < (i - start) {
					largest.value = num
					largest.index = i
				}
			}
		}
	}

	return largest
}

run :: proc(aoc: utils.aoc_data) -> int {
	acc := 0

	data := string(aoc.data)
	defer delete(data)

	it := strings.split_lines(data)
	defer delete(it)

	for line, li in &it {
		utils.print_message(aoc, "starting line: ", li, "::", line)

		arr := make([dynamic]some_value, 0)
		defer delete(arr)

		largest := get_largest(line, 0, len(line))

		utils.print_message(aoc, "LARGEST:", largest)
		append(&arr, largest)

		last_picked := largest.index

		fill_remaining := false

		if len(line) - 1 - largest.index < 11 {
			// if we don't have enough digits behind the largest value, take all beyond largest value
			for v, i in line[largest.index + 1:] {
				utils.print_message(aoc, "FILLING WITH:", v, "|", i)
				num := local_utils.get_number(line, i)
				blah := some_value {
					value = num,
					index = i,
				}
				append(&arr, blah)
			}
			// and fill remaining from infront of the largest value
			fill_remaining = true
			utils.print_message(aoc, "==== FILL REQUIRED ====")
			last_picked = largest.index - 1
		}

		// continue until we have 12 values in our array
		for len(arr) < 12 {

			if fill_remaining {
				// we took everything we could behind the largest value and need more, take from in front of it
				utils.print_message(
					aoc,
					"GETTING LARGEST BETWEEN",
					0,
					"and",
					last_picked,
					":: closest:",
					true,
				)

				num := get_largest(line, 0, last_picked)

				last_picked = num.index

				append(&arr, num)
			} else {
				// take from behind the largest value, we have enough to fill the array
				utils.print_message(
					aoc,
					"GETTING LARGEST BETWEEN",
					last_picked + 1,
					"and",
					len(line),
					":: closest:",
					false,
				)

				num := get_largest(line, last_picked + 1, len(line), false)

				utils.print_message(aoc, "==> GOT:", num)

				last_picked = num.index

				utils.print_message(aoc, "==> last picked:", last_picked)

				append(&arr, num)
			}
		}

		utils.print_message(aoc, "ARR STATE:", arr)

	}

	return acc
}
