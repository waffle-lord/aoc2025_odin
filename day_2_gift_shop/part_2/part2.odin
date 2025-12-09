package part2

import "../../utils"
import "core:math"
import "core:math/bits"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"

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

		utils.print_message(aoc, "start:", start, "end:", end, debug = true)

		for n in start ..= end {
			buf: [64]byte
			n_string := strconv.write_int(buf[:], i64(n), 10)

			first := n_string[0]

			seq := make([dynamic]rune, 0)
			defer delete(seq)

			append(&seq, rune(first))

			done := false
			// startsng at 1 to skip first rune. It is always added to seq
			for r in n_string[1:] {

				if done {
					break
				}

				if r == seq[0] && len(n_string) % len(seq) == 0 {
					// rune is the first in the seq so far, and number of digits can be divided evenly by seq length
					cycles := len(n_string) / len(seq)

					seqString := utf8.runes_to_string(seq[:])
					defer delete(seqString)

					seqNumber := strings.builder_make()

					for i in 0 ..< cycles {
						strings.write_string(&seqNumber, seqString)
					}

					built_id := strings.to_string(seqNumber)
					defer delete(built_id)

					// seq was correct and ID is invalid
					utils.print_message(
						aoc,
						"n_s:",
						n_string,
						"n:",
						n,
						"built:",
						built_id,
						debug = true,
					)


					if built_id == n_string {
						utils.print_message(aoc, "BAD ID FOUND:", built_id)
						acc += n
						done = true
						break
					}
				}

				append(&seq, r)
				utils.print_message(aoc, "seq updated:", seq, debug = true)
			}
		}
	}

	utils.print_message(aoc, "answer:", acc)

	return acc
}
