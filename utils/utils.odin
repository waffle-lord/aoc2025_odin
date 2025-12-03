package utils

import "core:fmt"
import "core:os"
import "core:strings"

aoc_data :: struct {
	tag:             string,
	print_verbose:   bool,
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

print_verbose_message :: proc(aoc: aoc_data, message: string) {
	if aoc.print_verbose {
		fmt.println(aoc.tag, "::", message)
	}
}

print_message :: proc(aoc: aoc_data, message: string) {
	fmt.println(aoc.tag, "::", message)
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
