package part2

import "../../utils"
import "../local_utils"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"


run :: proc(aoc: utils.aoc_data) -> int {
	acc := 0

	data := string(aoc.data)
	defer delete(data)

	it := strings.split_lines(data)
	defer delete(it)

	for line, li in &it {

		utils.print_message(aoc, "starting line: ", li)
		// reverse array so we only need to push indexes "up" the array (I don't like working backwards :)
		r_line := strings.reverse(line)
		defer delete(r_line)

		// setup the first 12 index in the line as our starting indexes
		arr: [12]int

		for i in 0 ..< 12 {
			arr[i] = i
		}

		// starting at 12 (13th element) to begin checking after our initial index setup
		arr_point := 12
		point := 11
		c_end := len(line)
		current := -1

		for {
			// TODO: check if last index in arr can be moved up to the last highest value in the line.
			// Do this until no higher value numbers are found and collect the arr values
			// join, reverse and convert to int. Add to acc
			c_num := local_utils.get_number(line, point)

			c_start := point + 1
			arr_point -= 1

			if arr_point == -1 {
				break
			}

			utils.print_message(aoc, "start:", c_start, "end:", c_end)

			for i in c_start ..< c_end {
				num := local_utils.get_number(line, i)

				utils.print_message(aoc, "num:", num, "/", i, "c_num:", c_num, "/", point)

				if (num > c_num) {
					utils.print_message(aoc, "current index changed:", current, "->", i)
					current = i
				}
			}

			if current == -1 {
				// no more numbers to switch
				break
			} else {
				utils.print_message(aoc, "ap:", arr[arr_point], "->", current)
				arr[arr_point] = current
				c_end = current - 1
			}
		}

		str_arr: [12]rune

		utils.print_message(aoc, arr, str_arr)

		for v, i in arr {
			str_arr[i] = rune(line[v])
		}

		utils.print_message(aoc, arr, str_arr)

		str := utf8.runes_to_string(str_arr[:])
		defer delete(str)

		n_str, ok := strconv.parse_int(str, 10)

		if !ok {
			panic("failed to parse int")
		}

		acc += n_str
		utils.print_message(aoc, "ACC UPDATED:", acc)
	}

	return acc
}
