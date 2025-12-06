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
		message := fmt.aprint("failed to read input file:", aoc.input_file_path)
		panic(message)
	}

	info := fmt.aprint("data is", len(aoc.data), "bytes")
	defer delete(info)
	print_message(aoc, info)

	return aoc
}


print_message :: proc(aoc: aoc_data, message: ..any, debug: bool = false) {
	msgformatted := fmt.aprint(..message)
	output := fmt.aprint(aoc.tag, "::", msgformatted)

	if debug {
		log.debug(output)
	} else {
		log.info(output)
	}

	delete(msgformatted)
	delete(output)
}

load_file_data :: proc(aoc: ^aoc_data) {
	data, ok := os.read_entire_file(aoc.input_file_path)

	if !ok {
		return
	}
	defer delete(data)

	aoc.data = make([]byte, len(data))

	for v, i in data {
		aoc.data[i] = v
	}
}
