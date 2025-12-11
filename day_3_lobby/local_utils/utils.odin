package local_utils

import "core:fmt"
import "core:strconv"
import "core:unicode/utf8"

get_number :: proc(line: string, index: int) -> int {

	if len(line) - 1 < index {
		return -1
	}

	r := rune(line[index])
	str := utf8.runes_to_string({r})
	defer delete(str)
	num, ok := strconv.parse_int(str, 10)

	if !ok {
		msg := fmt.aprint("failed to parse int:", str)
		panic(msg)
	}

	return num
}
