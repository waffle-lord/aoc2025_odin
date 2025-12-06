package part1

import "../../utils"
import "core:fmt"
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
	dial := 50

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

		remainder := action.amount % 100

		if remainder > 0 {
			action.amount = remainder
		}

		#partial switch action.direction {
		case direction.LEFT:
			dial -= action.amount
		case direction.RIGHT:
			dial += action.amount
		}

		if dial > 99 {
			dial -= 100
		} else if dial < 0 {
			dial += 100
		}


		utils.print_message(aoc, "dial NEW ->", dial, debug = true)

		if dial == 0 {
			acc += 1
			utils.print_message(aoc, "ACC updated:", acc, debug = true)
		}
	}

	utils.print_message(aoc, "answer:", acc)
	return acc
}
