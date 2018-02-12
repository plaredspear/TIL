# https://www.hackerrank.com/challenges/palindrome-index/problem
class PalindromeIndex
  def initialize(input)
    @input = input
  end

  def palindrome?(string)
    (0..(string.length / 2)).each do |i|
      return false if string[i] != string[string.length - 1 - i]
    end
    true
  end

  def palindrome_first_diff(string)
    (0..(string.length / 2)).each do |i|
      return i if string[i] != string[string.length - 1 - i]
    end

    -1
  end

  def palindrome_index
    first_diff_index = palindrome_first_diff(@input)

    return -1 if first_diff_index == -1

    # left one
    removed_string = @input[(first_diff_index + 1)...(@input.length - first_diff_index)]
    return first_diff_index if palindrome?(removed_string)

    # right one
    removed_string = @input[first_diff_index...(@input.length - first_diff_index - 1)]
    return @input.length - 1 - first_diff_index if palindrome?(removed_string)

    -1
  end
end
