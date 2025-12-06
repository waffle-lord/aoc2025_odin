package part1

import "../../utils"
import "core:strconv"
import "core:strings"

run :: proc(aoc: utils.aoc_data) -> int {
	acc := 0

	data := string(aoc.data)
	defer delete(data)

	id_ranges := strings.split(data, ",")
	defer delete(id_ranges)

	for range in id_ranges {
		range_info := strings.split(range, "-")
		defer delete(range_info)

		if len(range_info) != 2 {
			panic("failed to split range info")
		}

		start, ok := strconv.parse_int(range_info[0])

		if !ok {
			panic("failed to parse start int")
		}

		end, okk := strconv.parse_int(range_info[1])

		if !okk {
			panic("failed to parse end int")
		}


		utils.print_message(aoc, "processing", range)

		for n in start ..= end {

			buf: [64]byte
			n_string := strconv.write_int(buf[:], i64(n), 10)
			digits := len(n_string)

			if digits % 2 != 0 {
				utils.print_message(aoc, "  >", n, "ignored", debug = true)
				continue
			}

			half_count := len(n_string) / 2
			sub, ok := strings.substring(n_string, 0, half_count)

			if !ok {
				panic("failed to get first half substring")
			}
			first_half := sub

			sub, ok = strings.substring(n_string, half_count, len(n_string))

			if !ok {
				panic("failed to get second half substring")
			}

			second_half := sub

			if first_half == second_half {
				utils.print_message(aoc, "bad ID", n, debug = true)
				utils.print_message(aoc, "new acc", acc, debug = true)
				acc += n
			}
		}
	}

	utils.print_message(aoc, "answer:", acc)
	return acc
}
