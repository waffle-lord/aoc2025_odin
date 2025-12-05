package utils

import "core:fmt"
import "core:log"
import "core:os"

aoc_data :: struct {
	tag:             string,
	data:            []byte,
	input_file_path: string,
}

get_aoc_data :: proc(tag: string, input_file: string) -> aoc_data {
	aoc := aoc_data {
		tag             = tag,
		input_file_path = input_file,
	}

	load_file_data(&aoc)

	if len(aoc.data) == 0 {
		panic(fmt.aprint("failed to read input file:", aoc.input_file_path))
	}

	print_message(aoc, fmt.aprint("data is", len(aoc.data), "bytes"))

	return aoc
}


print_message :: proc(aoc: aoc_data, message: string, debug: bool = false) {
	fmt.println(aoc.tag, "::", message)
	if debug {
		log.debug(aoc.tag, "::", message)
	} else {
		log.info(aoc.tag, "::", message)
	}

}

load_file_data :: proc(aoc: ^aoc_data) {
	data, ok := os.read_entire_file(aoc.input_file_path, context.allocator)

	if !ok {
		return
	}
	defer delete(data, context.allocator)

	aoc.data = make([]byte, len(data))

	for v, i in data {
		aoc.data[i] = v
	}
}
