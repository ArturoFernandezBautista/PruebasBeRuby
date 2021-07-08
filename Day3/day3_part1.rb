
# ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]

require 'minitest/autorun'

class Day3P1

  def get_file_lines
    begin
      lines = File.read(__dir__+"/part1_codes.txt").split("\n")
    rescue
      puts "Invalid File or Route Doesn't match"
    end
  end
  
  def get_tree_count lines
    current_position = 0
    tree_count = 0
    lines.each do |line|

      while line[current_position].nil? || line[current_position].empty?
        line.concat(line)
      end
      
      case line[current_position]

      when "."
        line[current_position] = "O"
      when "#"
        line[current_position] = "X"
        tree_count += 1
      end

      current_position += 3
    end
    return tree_count
  end
end

## TESTING

class Day3P1Test < Minitest::Test

  def test_get_file_lines
    day3p1 = Day3P1.new
    assert day3p1.get_file_lines.kind_of?(Array)
  end

  def test_get_file_lines_not_empty
    day3p1 = Day3P1.new
    refute_empty day3p1.get_file_lines
  end

  def test_tree_count
    day3p1 = Day3P1.new
    lines = ["..##.......","#...#...#..",".#....#..#.","..#.#...#.#",".#...##..#.","..#.##.....",".#.#.#....#",".#........#","#.##...#...","#...##....#",".#..#...#.#"]
    assert day3p1.get_tree_count(lines) == 7
  end

  def test_solution
    day3p1 = Day3P1.new
    # Show solution
    p solution = day3p1.get_tree_count(day3p1.get_file_lines)
    assert solution == 223
  end
end

