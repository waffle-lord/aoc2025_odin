package utils

import "core:os"
import "core:strings"

get_file_lines :: proc(filepath: string) -> []string {
	data, ok := os.read_entire_file(filepath, context.allocator)

	if !ok {
		return []string{}
	}
	defer delete(data, context.allocator)


	return strings.split_lines(string(data))
}
