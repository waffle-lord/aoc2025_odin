package part1

import "../../utils"
import "../local_utils"
import "core:fmt"
import "core:os"
import "core:strconv"

run :: proc(aoc: utils.aoc_data) -> int {
	acc := 0

	inventory := local_utils.parse_inventory_data(aoc.data)
	defer delete(inventory.fresh_id_ranges)
	defer delete(inventory.ids)

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

	for id in inventory.ids[:] {

		fmt.printfln("%w", id)
		id_num, ok := strconv.parse_u64(id)

		if !ok {
			utils.print_message(aoc, "X--X ERROR: failed to parse ID:", id)
			panic("failed to parse id")
		}

		fmt.println("NUM ID:", id_num)

		// TODO: look into why this doesn't work or just remove it from all projects because idk wtf I'm doing
		// utils.print_message(aoc, "checking ID:", id_num)

		for range in ranges {
			if id_num >= range.start && id_num <= range.end {
				acc += 1
				break
			}
		}
	}

	utils.print_message(aoc, "answer:", acc)
	return acc
}
