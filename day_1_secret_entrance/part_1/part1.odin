package part1

import "../../utils"
import "core:fmt"
import "core:strconv"
import "core:strings"

print_message :: proc(message: string) {
	fmt.println("part 1 ::", message)
}

run :: proc(input_file: string, verbose: bool) {
	data := utils.get_file_lines(input_file)

	if len(data) == 0 {
		print_message("failed to read input file")
	}

	acc := 0
	dial := 50

	for line in data {

		if strings.has_prefix(line, "L") {

			amount, ok := strconv.parse_int(line[1:])

			if !ok {
				print_message(fmt.aprint("failed to parse amount:", line))
			}

			if verbose {
				print_message(fmt.aprint("dial:", dial, "\nLEFT: ", amount))
			}

			dial -= amount
		} else if strings.has_prefix(line, "R") {

			amount, ok := strconv.parse_int(line[1:])


			if !ok {
				print_message(fmt.aprint("failed to parse amount:", line))
			}

			if verbose {
				print_message(fmt.aprint("dial:", dial, "\nRIGHT: ", amount))
			}

			dial += amount
		}

		if dial > 99 {
			dial -= 100
		} else if dial < 0 {
			dial += 100
		}


		if verbose {
			fmt.println("->", dial)
		}

		if dial == 0 {
			acc += 1
			if verbose {
				fmt.println("ACC updated:", acc)
			}
		}
	}

	print_message(fmt.aprint("answer:", acc))
}
