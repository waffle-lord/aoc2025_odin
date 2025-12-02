package utils

import "core:fmt"
import "core:os"
import "core:strings"

print_message :: proc(message: string) {
	fmt.println("utils ::", message)
}

get_file_lines :: proc(filepath: string) -> []string {
	data, ok := os.read_entire_file(filepath, context.allocator)

	if !ok {
		print_message("data is NOT ok")
		return []string{}
	}
	defer delete(data, context.allocator)

	print_message(fmt.aprint("data length is", len(data), "bytes"))

	return strings.split_lines(string(data))
}
