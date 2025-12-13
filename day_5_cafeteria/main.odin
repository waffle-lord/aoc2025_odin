package main

import "../utils"
import "./part_1"
import "./part_2/"
import "base:runtime"
import "core:fmt"
import "core:log"
import "core:mem"
import "core:testing"

@(test)
part_1_test :: proc(t: ^testing.T) {
	expected_answer := 3
	test_input := utils.get_aoc_data("part 1 TEST", "./test_input.txt")
	answer := part_1.run(test_input)

	err_message := fmt.aprint("answer", answer, "not equal", expected_answer)
	defer delete(err_message)

	testing.expect(t, answer == expected_answer, err_message)
}

@(test)
part_2_test :: proc(t: ^testing.T) {
	expected_answer := 14
	test_input := utils.get_aoc_data("part 2 TEST", "./test_input.txt")
	answer := part_2.run(test_input)

	err_message := fmt.aprint("answer", answer, "not equal", expected_answer)
	defer delete(err_message)

	testing.expect(t, answer == expected_answer, err_message)
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

	logger := log.create_console_logger()
	logger.lowest_level = runtime.Logger_Level.Info
	defer log.destroy_console_logger(logger)
	context.logger = logger

	part_1_challenge := utils.get_aoc_data("part 1", "./input.txt")
	part_1.run(part_1_challenge)


	part_2_challenge := utils.get_aoc_data("part 2", "./input.txt")
	part_2.run(part_2_challenge)
}
