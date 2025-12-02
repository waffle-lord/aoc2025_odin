package main

import "../utils"
import "core:fmt"


main :: proc() {
	inputFilePath := "./day_1_part_1_input.txt"
	data := utils.get_file_lines(inputFilePath)

	if len(data) == 0 {
		fmt.println("no data to parse")
		return
	}

	for line, index in data {
		// TODO: parse data in file
	}
}
