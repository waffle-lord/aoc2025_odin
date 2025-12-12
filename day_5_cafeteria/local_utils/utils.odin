package local_utils

import "../../utils"
import "core:strconv"
import "core:strings"

inventory_data :: struct {
	fresh_id_ranges: [dynamic]string,
	ids:             [dynamic]string,
}

range_data :: struct {
	start: u64,
	end:   u64,
}


parse_inventory_data :: proc(input: []byte) -> inventory_data {

	data := string(input)
	defer delete(data)

	data = strings.trim(data, "\n")

	invt := inventory_data{}

	it := strings.split_lines(data)
	defer delete(it)

	for line in &it {
		if strings.contains(line, "-") {
			append(&invt.fresh_id_ranges, line)
		} else if strings.trim_space(line) == "" {
			continue
		} else {
			append(&invt.ids, line)
		}
	}

	return invt
}

parse_ranges :: proc(ranges: []string) -> []range_data {

	parsed_ranges := make([dynamic]range_data, 0)

	for r in ranges {
		split := strings.split(r, "-")
		defer delete(split)

		if len(split) != 2 {
			panic("failed to split range")
		}

		s := split[0]

		parsed, ok := strconv.parse_u64(split[0])

		if !ok {
			panic("failed to parse range start")
		}

		start := parsed

		parsed, ok = strconv.parse_u64(split[1])

		if !ok {
			panic("failed to parse range end")
		}

		end := parsed

		append(&parsed_ranges, range_data{start = start, end = end})
	}

	return parsed_ranges[:]
}
