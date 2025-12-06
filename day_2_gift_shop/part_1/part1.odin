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
			panic("sjdlfkjsldfj")
		}

		start, ok := strconv.parse_int(range_info[0])

		if !ok {
			panic("oiuoiuweoriuweoiru")
		}

		end, okk := strconv.parse_int(range_info[1])

		if !okk {
			panic("zklxclzkjxlkzxxikc")
		}


		utils.print_message(aoc, range)

		for n in start ..= end {

			buf: [4]byte
			n_string := strconv.write_int(buf[:], i64(n), 10)
			digits := len(n_string)

			if digits % 2 != 0 {
				utils.print_message(aoc, "  >", n, "ignored")
				continue
			}

			utils.print_message(aoc, "  >", n)
		}
	}

	return acc
}
