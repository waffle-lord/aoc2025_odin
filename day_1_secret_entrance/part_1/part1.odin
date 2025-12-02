package part1

import "../../utils"
import "core:fmt"
import "core:strconv"
import "core:strings"


run :: proc(aoc: utils.aoc_data) {
	acc := 0
	dial := 50

	for line in aoc.data {

		if strings.has_prefix(line, "L") {

			amount, ok := strconv.parse_int(line[1:])

			if !ok {
				utils.print_message(aoc, fmt.aprint("failed to parse amount:", line))
			}

			utils.print_verbose_message(aoc, fmt.aprint("dial:", dial, "\nLEFT: ", amount))

			dial -= amount
		} else if strings.has_prefix(line, "R") {

			amount, ok := strconv.parse_int(line[1:])

			if !ok {
				utils.print_message(aoc, fmt.aprint("failed to parse amount:", line))
			}

			utils.print_verbose_message(aoc, fmt.aprint("dial:", dial, "\nRIGHT: ", amount))

			dial += amount
		}

		if dial > 99 {
			dial -= 100
		} else if dial < 0 {
			dial += 100
		}


		utils.print_verbose_message(aoc, fmt.aprint("->", dial))

		if dial == 0 {
			acc += 1
			utils.print_verbose_message(aoc, fmt.aprint("ACC updated:", acc))
		}
	}

	utils.print_message(aoc, fmt.aprint("answer:", acc))
}
