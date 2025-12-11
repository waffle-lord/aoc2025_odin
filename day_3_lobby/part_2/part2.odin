package part2

import "../../utils"
import "../local_utils"
import "core:path/filepath"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"

some_value :: struct {
	value: int,
	index: int,
}

get_largest :: proc(line: string, start: int, end: int) -> some_value {

	largest := some_value {
		value = -1,
		index = -1,
	}

	for v, i in line[start:end] {
		num := local_utils.get_number(line, i)
		if num > largest.value {
			largest.value = num
			largest.index = i
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
		utils.print_message(aoc, "starting line: ", li)

		arr := make([dynamic]some_value, 0)
		defer delete(arr)

		largest := get_largest(line, 0, len(line))

		append(&arr, largest)

		fill_remaining := false

		if len(line) - 1 - largest.index < 11 {
			// if we don't have enough digits behind the largest value, take all beyond largest value
			for v, i in line[largest.index + 1:] {
				num := local_utils.get_number(line, i)
				blah := some_value {
					value = num,
					index = i,
				}
				append(&arr, blah)
			}
			// and fill remaining from infront of the largest value
			fill_remaining = true
		}

		// continue until we have 12 values in our array
		for len(arr) < 12 {
			// TODO: How Do
			// [X] get the largest value
			// [X] if number of values beyond the largest value is less than 11 (not enough to fill the array), take all of them
			// [ ] otherwise, search range beyond largest value, to fill array
			// [ ] take numbers beyond the largest value with higher indexes first
			// [ ] if needed, fill remaining array with values before largest value, taking largest number with the index closest to the largest value first


			if fill_remaining {
				// we took everything we could behind the largest value and need more, take from in front of it

			} else {
				// take from behind the largest value, we have enough to fill the array

			}

		}

	}

	return acc
}
