package part2

import "../../utils"
import "../local_utils"

is_inside_range :: proc(num: u64, range: local_utils.range_data) -> bool {
	return num >= range.start && num <= range.end
}

run :: proc(aoc: utils.aoc_data) -> int {
	acc := 0

	inventory := local_utils.parse_inventory_data(aoc.data)
	defer delete(inventory.fresh_id_ranges)
	delete(inventory.ids)

	utils.print_message(
		aoc,
		"fresh ranges count:",
		len(inventory.fresh_id_ranges),
		"| ids count:",
		len(inventory.ids),
	)

	utils.print_message(aoc, "parsing ranges ...")

	ranges := local_utils.parse_ranges(inventory.fresh_id_ranges[:])

	utils.print_message(aoc, len(ranges), "parsed")

	ids := make([dynamic]local_utils.range_data, 0)

	for range in ranges {
		utils.print_message(aoc, "checking range:", range)

		found := false

		for &id_range in ids {

			if is_inside_range(range.start, id_range) && is_inside_range(range.end, id_range) {
				utils.print_message(aoc, "skip")
				found = true
				break
			}

			if is_inside_range(range.start, id_range) && range.end > id_range.end {
				utils.print_message(aoc, "update existing range end:", range, id_range)
				id_range.end = range.end
				found = true
				break
			}

			if is_inside_range(range.end, id_range) && range.start < id_range.start {
				utils.print_message(aoc, "update existing range start:", range, id_range)
				id_range.start = range.start
				found = true
				break
			}
		}

		if !found {
			utils.print_message(aoc, "full add:", range)
			append(&ids, range)
		}
	}

	collapsing := true

	for collapsing {
		collapsing = false

		tmp := make([dynamic]local_utils.range_data, 0)


		for range in ids {
			append(&tmp, range)
		}

		for &range in ids {

		}
	}

	for id_range in ids {
		utils.print_message(aoc, "range", id_range.start, "-", id_range.end)
		for i in id_range.start ..= id_range.end {
			acc += 1
		}
	}

	utils.print_message(aoc, "answer:", acc)
	return acc
}
