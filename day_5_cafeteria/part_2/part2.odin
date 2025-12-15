package part2

import "../../utils"
import "../local_utils"
import "core:os"

is_inside_range :: proc(num: u64, range: local_utils.range_data) -> bool {
	return num >= range.start && num <= range.end
}

remove_uneeded :: proc(aoc: utils.aoc_data, ranges: ^[dynamic]local_utils.range_data) {
	had_removals := true

	for had_removals {
		had_removals = false
		total := len(ranges)

		#reverse for r, i in ranges {
			for rr, ii in ranges {
				if i == ii {
					continue
				}
				if is_inside_range(r.start, rr) && is_inside_range(r.end, rr) {
					utils.print_message(aoc, "removing uneeded range:", r)
					had_removals = true
					unordered_remove(ranges, i)
					break
				}
			}
		}
	}
}

append_ranges :: proc(aoc: utils.aoc_data, ranges: ^[dynamic]local_utils.range_data) {

	ids := make([dynamic]local_utils.range_data, 0)
	defer delete(ids)

	for range in ranges {
		utils.print_message(aoc, "checking range:", range, debug = true)

		found := false

		for &id_range in ids {

			if is_inside_range(range.start, id_range) && is_inside_range(range.end, id_range) {
				utils.print_message(aoc, "skip", debug = true)
				found = true
				break
			}

			if is_inside_range(range.start, id_range) && range.end > id_range.end {
				utils.print_message(
					aoc,
					"update existing range end:",
					range,
					id_range,
					debug = true,
				)
				id_range.end = range.end
				found = true
				break
			}

			if is_inside_range(range.end, id_range) && range.start < id_range.start {
				utils.print_message(
					aoc,
					"update existing range start:",
					range,
					id_range,
					debug = true,
				)
				id_range.start = range.start
				found = true
				break
			}
		}

		if !found {
			utils.print_message(aoc, "full add:", range, debug = true)
			append(&ids, range)
		}
	}
}

collapse_ranges :: proc(aoc: utils.aoc_data, ranges: ^[dynamic]local_utils.range_data) -> bool {
	was_collasped := false

	ids := make([dynamic]local_utils.range_data, 0)
	defer delete(ids)

	append(&ids, ..ranges[:])

	for range in ranges {
		utils.print_message(aoc, "checking range:", range, debug = true)

		found := false

		for &id_range in ids {

			if is_inside_range(range.start, id_range) && is_inside_range(range.end, id_range) {
				utils.print_message(aoc, "skip", debug = true)
				found = true
				break
			}

			if is_inside_range(range.start, id_range) && range.end > id_range.end {
				utils.print_message(
					aoc,
					"update existing range end:",
					range,
					id_range,
					debug = true,
				)
				id_range.end = range.end
				was_collasped = true
				found = true
				break
			}

			if is_inside_range(range.end, id_range) && range.start < id_range.start {
				utils.print_message(
					aoc,
					"update existing range start:",
					range,
					id_range,
					debug = true,
				)
				id_range.start = range.start
				was_collasped = true
				found = true
				break
			}
		}
	}

	clear(ranges)
	append(ranges, ..ids[:])

	return was_collasped
}

run :: proc(aoc: utils.aoc_data) -> u64 {
	acc := u64(0)

	defer delete(aoc.data)

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

	ranges := make([dynamic]local_utils.range_data, 0)
	defer delete(ranges)

	append(&ranges, ..local_utils.parse_ranges(inventory.fresh_id_ranges[:]))

	utils.print_message(aoc, len(ranges), "parsed")

	count := 0

	append_ranges(aoc, &ranges)

	for collapse_ranges(aoc, &ranges) {
		if (count > 14) {
			panic("fuck!")
		}
		count += 1
		utils.print_message(aoc, ">> << COLLAPSED", count, "TIMES >> <<")
	}

	utils.print_message(aoc, "STARTING REMOVAL CHECKS ...")
	remove_uneeded(aoc, &ranges)

	utils.print_message(aoc, "COUNTING RANGES ...")
	for r in ranges {
		amount := r.end - r.start + 1
		utils.print_message(aoc, "range", r.start, "-", r.end, "::", amount)
		acc += amount
	}

	utils.print_message(aoc, "answer:", acc)
	return acc
}
