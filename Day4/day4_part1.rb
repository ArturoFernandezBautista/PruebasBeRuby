
# ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]

require 'minitest/autorun'

class Day4P1

  def get_file_lines
    begin
      lines = File.read(__dir__+"/part1_codes.txt").split("\n")
    rescue
      puts "Invalid File or Route Doesn't match"
    end
  end

  def get_passports lines
    passport = []
    passports = []

    lines.each_with_index do | line , index |
      if line.empty?
        passports << passport
        passport = []
        next
      else
        line.split(" ").select { |code_data| passport << code_data.split(":")[0]+ ":" + code_data.split(":")[1] }
      end

      if line == lines.last
        passports << passport
      end
    end
    return passports
  end

  def validate_passports passports
    valid_passports = 0
    mandatory_keys = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
    passports.select { |passport| valid_passports += 1 if mandatory_keys.all?{ |key| (passport.map { |k| k.split(":")[0] }).include?(key) }}
   
    return valid_passports
  end

  def solution lines
    validate_passports(get_passports(lines))
  end
end

## TESTING 

class Day4P1Test < Minitest::Test

  def test_get_file_lines
    day4p1 = Day4P1.new
    assert day4p1.get_file_lines.kind_of?(Array)
  end

  def test_get_file_lines_not_empty
    day4p1 = Day4P1.new
    refute_empty day4p1.get_file_lines
  end

  def test_get_passports
    day4p1 = Day4P1.new
    test_passports = ["ecl:gry pid:860033327 eyr:2020 hcl:#fffffd" , "byr:1937 iyr:2017 cid:147 hgt:183cm" , "" , "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884" , "hcl:#cfa07d byr:1929" , "" , "hcl:#ae17e1 iyr:2013" , "eyr:2024" , "ecl:brn pid:760753108 byr:1931" , "hgt:179cm" , "" , "hcl:#cfa07d eyr:2025 pid:166559648" , "iyr:2011 ecl:brn hgt:59in"]
    assert day4p1.get_passports(test_passports).size == 4
  end

  def test_validate_passports
    day4p1 = Day4P1.new
    test_passports = [["byr:2222222", "hcl:#118493", "pid:458049702", "cid:99", "iyr:2019", "eyr:2023"], ["hcl:#a97842", "eyr:2021", "cid:261", "hgt:61in", "pid:162402242", "ecl:amb", "byr:1938", "iyr:2016"], ["iyr:2016", "hgt:187cm", "byr:1980", "pid:977322718", "eyr:2027", "ecl:brn", "hcl:#ceb3a1"], ["iyr:2010", "ecl:oth", "pid:455361219", "hgt:153cm", "eyr:2027", "hcl:#6b5442", "byr:1965"]]
    assert day4p1.validate_passports(test_passports) == 3
  end

  def test_solution
    day4p1 = Day4P1.new
    p result = day4p1.solution(day4p1.get_file_lines)
    assert result == 206
  end
end




