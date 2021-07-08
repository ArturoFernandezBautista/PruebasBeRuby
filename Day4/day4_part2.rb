
# ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]

require 'minitest/autorun'

class Day4P2

  def get_file_lines
    begin
      lines = File.read(__dir__+"/part2_codes.txt").split("\n")
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

  def validate_field field
    field_code = field[0]
    field_data = field[1]
    is_valid = false

    case field_code
      when "byr"
        is_valid = true if !!field_data.match(/(19[2-9][0-9])|((200)[0-2])/)
      when "iyr"
        is_valid = true if !!field_data.match(/(201[0-9])|((2020))/)
      when "eyr"
        is_valid = true if !!field_data.match(/(202[0-9])|((2030))/)
      when "hgt"
        is_valid = true if !!field_data.match(/((1[5-8][0-9]|(19[0-3]))cm)|((59|(6[0-9])|(7[0-6]))in)/)
      when "hcl"
        is_valid = true if !!field_data.match(/#[0-9a-f]{6}/i)
      when "ecl"
        is_valid = true if !!field_data.match(/amb|blu|brn|gry|grn|hzl|oth|/)
      when "pid"
        is_valid = true if !!field_data.match(/([0-9]{9})/)
      when "cid"
        return true
      end

    return is_valid
  end

  def validate_passports passports
    valid_passports = 0
    mandatory_keys = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
    passports.select { |passport| valid_passports += 1 if mandatory_keys.all?{ |key| (passport.map { |k| k.split(":")[0] if validate_field(k.split(":"))}).include?(key) }}
   
    return valid_passports
  end

  def solution lines
    validate_passports(get_passports(get_file_lines))
  end

end

## TESTING 

class Day4P2Test < Minitest::Test

  def test_get_file_lines
    day4p2 = Day4P2.new
    assert day4p2.get_file_lines.kind_of?(Array)
  end

  def test_get_file_lines_not_empty
    day4p2 = Day4P2.new
    refute_empty day4p2.get_file_lines
  end

  def test_get_passports
    day4p2 = Day4P2.new
    test_passports = ["ecl:gry pid:860033327 eyr:2020 hcl:#fffffd" , "byr:1937 iyr:2017 cid:147 hgt:183cm" , "" , "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884" , "hcl:#cfa07d byr:1929" , "" , "hcl:#ae17e1 iyr:2013" , "eyr:2024" , "ecl:brn pid:760753108 byr:1931" , "hgt:179cm" , "" , "hcl:#cfa07d eyr:2025 pid:166559648" , "iyr:2011 ecl:brn hgt:59in"]
    assert day4p2.get_passports(test_passports).size == 4
  end

  def test_valid_field
    day4p2 = Day4P2.new
    assert day4p2.validate_field(["byr","2002"]) == true
  end

  def test_invalid_field
    day4p2 = Day4P2.new
    assert day4p2.validate_field(["byr","2020"]) != true
  end

  def test_validate_passports
    day4p2 = Day4P2.new
    test_passports = [["ecl:amb", "hgt:165cm", "byr:2222222", "hcl:#118493", "pid:458049702", "cid:99", "iyr:2019", "eyr:2023"], ["hcl:#a97842", "eyr:2021", "cid:261", "hgt:61in", "pid:162402242", "ecl:amb", "byr:1938", "iyr:2016"], ["iyr:2016", "hgt:187cm", "byr:1980", "pid:977322718", "eyr:2027", "ecl:brn", "hcl:#ceb3a1"], ["iyr:2010", "ecl:oth", "pid:455361219", "hgt:153cm", "eyr:2027", "hcl:#6b5442", "byr:1965"]]
    assert day4p2.validate_passports(test_passports) == 3
  end

  def test_solution
    day4p2 = Day4P2.new
    p result = day4p2.solution(day4p2.get_file_lines)
    assert result == 185
  end
end




