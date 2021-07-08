
# ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]
# Puede ocurrir incompatibilidad por el uso de una versión anterior, solution1 filter_map added >= 2.7 

require 'minitest/autorun'

class Day2P1
  
  def get_file_codes
  	begin
  	  # Split the codes in rules and password
	  codes = File.read(__dir__+"/part1_codes.txt").split("\n").map{|line| {code: line.split(": ")[0] , pass: line.split(": ")[1]} }
	rescue
      puts "Invalid File or Route Doesn't match"
	end
  end

  def test_pass code, pass
	code_splited = code.split(" ")
	numbers = code_splited[0]
	character = code_splited[1]
	numbers_splited = numbers.split("-")
	min = numbers_splited[0].to_i
	max = numbers_splited[1].to_i

	result = (pass.count(character) >= min && pass.count(character) <= max) ? true : false
  end

  def count_ocurrences codes
  	solution = codes.filter_map { |code| true if test_pass(code[:code],code[:pass]) }.size
  end

end

## TESTING

class Day2P1Test < Minitest::Test

	def test_get_file_codes
		day2p1 = Day2P1.new
		assert day2p1.get_file_codes.kind_of?(Array)
	end

	def test_valid_pass
		day2p1 = Day2P1.new
		assert day2p1.test_pass("1-3 a","abcde")
	end

	def test_invalid_pass
		day2p1 = Day2P1.new
		assert !day2p1.test_pass("1-3 b","cdefg")
	end

	def test_get_file_codes_not_empty
		day2p1 = Day2P1.new
		refute_empty day2p1.get_file_codes
	end

	def test_get_file_codes_numeric
		day2p1 = Day2P1.new
		assert day2p1.get_file_codes.all? {|i| i.is_a?(Hash) }
	end

	def test_solution
		day2p1 = Day2P1.new
		# Show solution
		p solution = day2p1.count_ocurrences(day2p1.get_file_codes)
		assert solution == 519
	end
end

