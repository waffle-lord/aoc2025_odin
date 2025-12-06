package main

import "../utils"
import "./part_1"
import "core:fmt"
import "core:mem"
import "core:testing"

@(test)
part_1_test :: proc(t: ^testing.T) {
	expected_answer := u64(1227775554)
	input_file := utils.get_aoc_data("part 1 TEST", "./test_2_input.txt")
	answer := part_1.run(input_file)

	testing.expect(
		t,
		answer == expected_answer,
		fmt.aprint("answer", answer, "is not equal", expected_answer),
	)
}

main :: proc() {
	track: mem.Tracking_Allocator
	mem.tracking_allocator_init(&track, context.allocator)
	context.allocator = mem.tracking_allocator(&track)

	defer {
		if len(track.allocation_map) > 0 {
			fmt.eprintf("=== %v allocations not freed: ===\n", len(track.allocation_map))
			// for _, entry in track.allocation_map {
			// 	fmt.eprintf("- %v bytes @ %v\n", entry.size, entry.location)
			// }
		}
		if len(track.bad_free_array) > 0 {
			fmt.eprintf("=== %v incorrect frees: ===\n", len(track.bad_free_array))
			// for entry in track.bad_free_array {
			// 	fmt.eprintf("- %p @ %v\n", entry.memory, entry.location)
			// }
		}
		mem.tracking_allocator_destroy(&track)
	}
}
