
# ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]
# Puede ocurrir incompatibilidad por el uso de una versión anterior, solution1 filter_map added >= 2.7 

require 'minitest/autorun'

class Day1P1

	def get_file_numbers
	  begin
		numbers = File.read(__dir__+"/part1_numbers.txt").split.map(&:to_i)
	  rescue
		puts "Invalid File or Route Doesn't match"
	  end
	end

	def solution1 numbers
	  numbers.product(numbers).filter_map { |number1 , number2| number1 * number2 if number1 + number2 == 2020 }.uniq
	end

	def solution2 numbers
	  result = []
	  numbers.each_with_index do |number1,index1|
	  	numbers.each_with_index do |number2,index2|
	  		if index1 != index2 && number1 + number2 == 2020
	  			result << number1 * number2
	  		end
	    end
	  end

	  return result.uniq
	end
end

## TESTING

class Day1P1Test < Minitest::Test

	def test_get_file_numbers
		day1p1 = Day1P1.new
		assert day1p1.get_file_numbers.kind_of?(Array)
	end

	def test_get_file_numbers_not_empty
		day1p1 = Day1P1.new
		refute_empty day1p1.get_file_numbers
	end

	def test_get_file_numbers_numeric
		day1p1 = Day1P1.new
		assert day1p1.get_file_numbers.all? {|i| i.is_a?(Integer) }
	end

	def test_solution1
		day1p1 = Day1P1.new
		# Show solution
		p solution = day1p1.solution1(day1p1.get_file_numbers)
		assert solution == [224436]
	end

	def test_solution2
		day1p1 = Day1P1.new
		# Show solution
		p solution = day1p1.solution2(day1p1.get_file_numbers)
		assert solution == [224436]
	end
end
