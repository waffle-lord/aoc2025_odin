package part2

import "../../utils"
import "core:math"
import "core:math/bits"
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

			boots := bits.bitfield_extract(n, 0, 8 * 32)

			utils.print_message(aoc, boots)
		}
	}

	utils.print_message(aoc, "answer:", acc)

	return acc
}
