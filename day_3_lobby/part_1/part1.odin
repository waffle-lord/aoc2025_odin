package part1

import "../../utils"
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

	for line in &it {
		left := -1
		right := -1

		r := rune(line[0])
		str := utf8.runes_to_string({r})
		num, ok := strconv.parse_int(str, 10)

		if !ok {
			msg := fmt.aprint("failed to parse int:", str)
			panic(msg)
		}

		// set initial left value to first number
		left = num

		total := len(line)
		point := 1

		for point <= total {
			// TODO: check each number in line
		}
	}

	return acc
}
