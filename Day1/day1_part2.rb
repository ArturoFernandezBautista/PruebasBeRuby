# ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]
# Puede ocurrir incompatibilidad por el uso de una versión anterior, solution array.product y filter_map added >= 2.7

require 'minitest/autorun'

class Day1P2

	def get_file_numbers
	  begin
	    numbers = File.read(__dir__+"/part2_numbers.txt").split.map(&:to_i)
	  rescue
	    puts "Invalid File or Route Doesn't match"
	  end
	end

	def solution numbers
	  results = numbers.product(numbers,numbers).filter_map { |number1 , number2 , number3 | number1 * number2 * number3 if number1 + number2 + number3 == 2020 }.uniq
	end
end

## TESTING

class Day1P2Test < Minitest::Test

	def test_get_file_numbers
		day1p2 = Day1P2.new
		assert day1p2.get_file_numbers.kind_of?(Array)
	end

	def test_get_file_numbers_not_empty
		day1p2 = Day1P2.new
		refute_empty day1p2.get_file_numbers
	end

	def test_get_file_numbers_numeric
		day1p2 = Day1P2.new
		assert day1p2.get_file_numbers.all? {|i| i.is_a?(Integer) }
	end

	def test_solution
		day1p2 = Day1P2.new
		# Show solution
		p solution = day1p2.solution(day1p2.get_file_numbers)
		assert solution == [303394260]
	end
end
