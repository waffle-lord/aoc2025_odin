package part2

import "../../utils"
import "../local_utils"
import "core:strings"

pos :: struct {
	x: int,
	y: int,
}

check_taken :: proc(t_arr: []pos, roll_pos: pos) -> bool {
	for p in t_arr {
		if p.x == roll_pos.x && p.y == roll_pos.y {
			return true
		}
	}

	return false
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

	lines := strings.split_lines(data)
	defer delete(lines)

	taken_arr := make([dynamic]pos, 0)
	defer delete(taken_arr)

	marked_arr := make([dynamic]pos, 0)
	defer delete(marked_arr)

	found_rolls := true
	count := 0

	for found_rolls {
		count += 1
		found_rolls = false

		utils.print_message(aoc, "###### STARTING ITERATION:", count, "with", len(lines), "lines")

		for line, y in &lines {
			utils.print_message(aoc, ">>> processing line", y, debug = true)
			valid_roll_count := 0

			for r, x in line {
				surrounding_rolls := 0
				if r == '@' {

					if check_taken(taken_arr[:], pos{x = x, y = y}) {
						utils.print_message(
							aoc,
							"__________ SKIP TAKEN ROLL:",
							x,
							"|",
							y,
							debug = true,
						)
						continue
					}

					utils.print_message(
						aoc,
						"checking for rolls surrounding",
						x,
						"|",
						y,
						debug = true,
					)
					check_posisitions := get_check_points(x, y)

					for p in check_posisitions {
						if p.x < 0 ||
						   p.x >= len(line) ||
						   p.y >= len(lines) ||
						   p.y < 0 ||
						   check_taken(taken_arr[:], p) {
							continue
						}

						if lines[p.y][p.x] == '@' {
							utils.print_message(aoc, "roll found at", p, debug = true)
							surrounding_rolls += 1
						}
					}

					if surrounding_rolls < 4 {
						utils.print_message(aoc, "@@@ VALID ROLL:", x, "|", y, debug = true)
						append(&marked_arr, pos{x = x, y = y})
						found_rolls = true
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

		utils.print_message(aoc, "X X X X MARKED:", len(marked_arr), debug = true)
		append(&taken_arr, ..marked_arr[:])
		clear(&marked_arr)
		utils.print_message(aoc, ". . . . TAKEN:", len(taken_arr), debug = true)

	}

	utils.print_message(aoc, "answer:", acc)
	return acc
}
