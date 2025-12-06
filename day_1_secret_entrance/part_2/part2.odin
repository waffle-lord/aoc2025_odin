package part2

import "../../utils"
import "core:fmt"
import "core:math"
import "core:strconv"
import "core:strings"

direction :: enum {
	INVALID,
	LEFT,
	RIGHT,
}

dial_action :: struct {
	direction: direction,
	amount:    int,
}


get_dial_action :: proc(line: string) -> dial_action {
	action := dial_action {
		direction = direction.INVALID,
	}

	if strings.has_prefix(line, "R") {
		action.direction = direction.RIGHT
	} else if strings.has_prefix(line, "L") {
		action.direction = direction.LEFT
	}

	if action.direction == direction.INVALID {
		return action
	}

	amount, ok := strconv.parse_int(line[1:])

	if !ok {
		return action
	}

	action.amount = amount

	return action
}

run :: proc(aoc: utils.aoc_data) -> int {
	acc := 0
	dial_position := 50

	data := string(aoc.data)
	defer delete(data)

	it := strings.split_lines(data)
	defer delete(it)

	for line in &it {

		utils.print_message(aoc, "parsing:", line, debug = true)

		action := get_dial_action(line)

		if action.direction == direction.INVALID {
			continue
		}

		bound, overflow, turn_amount := 0, 0, 0

		#partial switch action.direction {
		case direction.LEFT:
			bound = -1
			overflow = 99
			turn_amount = -1
		case direction.RIGHT:
			bound = 100
			overflow = 0
			turn_amount = 1
		}

		for i in 0 ..< action.amount {
			dial_position += turn_amount

			if dial_position == bound {
				dial_position = overflow
			}

			if dial_position == 0 {
				acc += 1
			}
		}
	}

	utils.print_message(aoc, "answer:", acc)
	return acc
}
