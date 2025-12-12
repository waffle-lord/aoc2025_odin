package part1

import "../../utils"
import "../local_utils"
import "core:strings"

pos :: struct {
	x: int,
	y: int,
}

get_check_points :: proc(roll_x: int, roll_y: int) -> [8]pos {
	return [8]pos {
		pos{x = roll_x - 1, y = roll_y},
		pos{x = roll_x + 1, y = roll_y},
		pos{x = roll_x - 1, y = roll_y - 1},
		pos{x = roll_x, y = roll_y - 1},
		pos{x = roll_x + 1, y = roll_y - 1},
		pos{x = roll_x - 1, y = roll_y + 1},
		pos{x = roll_x, y = roll_y + 1},
		pos{x = roll_x + 1, y = roll_y + 1},
	}
}

run :: proc(aoc: utils.aoc_data) -> int {
	acc := 0

	data := string(aoc.data)
	defer delete(data)

	data = strings.trim(data, "\n")

	utils.print_message(aoc, data)

	lines := strings.split_lines(data)
	defer delete(lines)


	for line, y in &lines {
		utils.print_message(aoc, ">>> processing line", y)
		valid_roll_count := 0

		for r, x in line {
			surrounding_rolls := 0
			if r == '@' {
				utils.print_message(aoc, "checking for rolls surrounding", x, "|", y, debug = true)
				check_posisitions := get_check_points(x, y)

				for p in check_posisitions {
					if p.x < 0 || p.x >= len(line) || p.y >= len(lines) || p.y < 0 {
						continue
					}

					if lines[p.y][p.x] == '@' {
						utils.print_message(aoc, "roll found at", p, debug = true)
						surrounding_rolls += 1
					}
				}

				if surrounding_rolls < 4 {
					utils.print_message(aoc, "@@@ VALID ROLL:", x, "|", y, debug = true)
					valid_roll_count += 1
				}
			}
		}

		utils.print_message(
			aoc,
			"@ - @ - @ - @ -:",
			valid_roll_count,
			"valid rolls in row",
			y,
			debug = true,
		)
		acc += valid_roll_count
	}

	utils.print_message(aoc, "answer:", acc)
	return acc
}
