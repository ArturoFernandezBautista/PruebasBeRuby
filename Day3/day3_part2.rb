
# ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]

require 'minitest/autorun'

class Day3P2

  def get_file_lines
    begin
      lines = File.read(__dir__+"/part2_codes.txt").split("\n")
    rescue
      puts "Invalid File or Route Doesn't match"
    end
  end

  def calculate_colision right_steps , down_steps , lines

    current_position_right = right_steps
    current_position_down = down_steps
    tree_count = 0
    lines.each_with_index do |line , index|
    next if (index % current_position_down != 0) ^ (index == 0)
    while line[current_position_right].nil? || line[current_position_right].empty?
      line.concat(line)
    end
    
    case line[current_position_right]
    when "."
      line[current_position_right] = "O"
    when "#"
      line[current_position_right] = "X"
      tree_count += 1
    end

    current_position_right += right_steps
    current_position_down += down_steps

  end
    return tree_count
  end

  def colisions_solution
    colisions = []

    colisions << calculate_colision(1 , 1 , get_file_lines)
    colisions << calculate_colision(3 , 1 , get_file_lines)
    colisions << calculate_colision(5 , 1 , get_file_lines)
    colisions << calculate_colision(7 , 1 , get_file_lines)
    colisions << calculate_colision(1 , 2 , get_file_lines)
  
    colisions.reject(&:zero?).inject(:*)
  end

end

## TESTING

class Day3P2Test < Minitest::Test

  def test_get_file_lines
    day3p2 = Day3P2.new
    assert day3p2.get_file_lines.kind_of?(Array)
  end

  def test_get_file_lines_not_empty
    day3p2 = Day3P2.new
    refute_empty day3p2.get_file_lines
  end

  def test_tree_count
    day3p2 = Day3P2.new
    lines = ["..##.......","#...#...#..",".#....#..#.","..#.#...#.#",".#...##..#.","..#.##.....",".#.#.#....#",".#........#","#.##...#...","#...##....#",".#..#...#.#"]
    assert day3p2.calculate_colision(3,1,lines) == 7
  end

  def test_solution
    day3p2 = Day3P2.new
    # Show solution
    p solution = day3p2.colisions_solution()
    assert solution == 3517401300
  end
end

