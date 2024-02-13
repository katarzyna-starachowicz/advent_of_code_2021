file_name = 'test_input.txt'
# file_name = 'input.txt'

#  AAAA
# F    B
# F    B
#  GGGG
# E    C
# E    C
#  DDDD

# digits with a unique number of segments
ONES_SEGMENTS_LENGTH = 2
FOURS_SEGMENTS_LENGTH = 4
SEVENS_SEGMENTS_LENGTH = 3
EIGHTS_SEGMENTS_LENGTH = 7

### Part 1
UNIQUE_DIGITS_LENGTHS = [ONES_SEGMENTS_LENGTH, FOURS_SEGMENTS_LENGTH, SEVENS_SEGMENTS_LENGTH, EIGHTS_SEGMENTS_LENGTH]
# number_of_unique_digits = 0
# 
# File.foreach(file_name) do |line|
#   _signals, displayed_digits = line.split('|').map(&:split)
#   number_of_unique_digits += displayed_digits.count { |digit| UNIQUE_DIGITS_LENGTHS.include?(digit.length) }
# end
# 
# p number_of_unique_digits


### Part 2
LETTERS_TO_NUMBERS_DICT = {
  'abcdef' => '0',
  'bc' => '1',
  'abdeg' => '2',
  'abcdg' => '3',
  'bcfg' => '4',
  'acdfg' => '5',
  'acdefg' => '6',
  'abc' => '7',
  'abcdefg' => '8',
  'abcdfg' => '9'
}

def figure_out_dictionary(signals)
  dictionary = { A: nil, B: nil, C: nil, D: nil, E: nil, F:  nil, G: nil }
  
  one = signals.find { |signal| signal.length == ONES_SEGMENTS_LENGTH }
  four = signals.find { |signal| signal.length == FOURS_SEGMENTS_LENGTH }
  seven = signals.find { |signal| signal.length == SEVENS_SEGMENTS_LENGTH }
  eight = signals.find { |signal| signal.length == EIGHTS_SEGMENTS_LENGTH }

  dictionary[:A] = (seven.split('') - one.split('')).first

  fe_unordered = signals
    .select { |signal| signal.length == 5 }
    .join.split('').tally
    .select { |encrypted_segment, number_of_occurance| number_of_occurance == 1 }.keys 

  dictionary[:E] = (fe_unordered - four.split('')).first

  dictionary[:F] = (fe_unordered - [dictionary[:E]]).first

  dictionary[:G] = (four.split('') - one.split('') - [dictionary[:F]]).first

  egb_unordered = signals
    .select { |signal| signal.length == 6 }
    .join.split('').tally
    .select { |encrypted_segment, number_of_occurance| number_of_occurance == 2 }.keys 

  dictionary[:B] = (egb_unordered - [dictionary[:E]] - [dictionary[:G]]).first

  dictionary[:C] = (one.split('') - [dictionary[:B]]).first

  dictionary[:D] = (eight.split('') - dictionary.values).first

  dictionary
end

def decipher_number(displayed_digits, dictionary)
  displayed_digits.map do |displayed_digit|
    desiphred_digit = displayed_digit.split('').map do |displayed_letter|
      dictionary.key(displayed_letter).to_s.downcase
    end.sort.join

    LETTERS_TO_NUMBERS_DICT[desiphred_digit]
  end.join.to_i
end

sum_of_numbers = 0 

File.foreach(file_name) do |line|
  signals, displayed_digits = line.split('|').map(&:split)
  dictionary = figure_out_dictionary(signals)
  n = decipher_number(displayed_digits, dictionary)
  sum_of_numbers += n
end

p sum_of_numbers

