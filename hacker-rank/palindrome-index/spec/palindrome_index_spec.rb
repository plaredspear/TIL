require 'palindrome_index'

RSpec.describe PalindromeIndex, "" do
  context 'palindrome?' do
    it 'is a palindrome' do
      ['aaa', 'aa'].each do |input|
        p = PalindromeIndex.new(input)

        expect(p.palindrome?(input)).to be true
      end
    end

    it 'is not a palindrome' do
      ['aaab', 'baa'].each do |input|
        p = PalindromeIndex.new(input)

        expect(p.palindrome?(input)).to be false
      end
    end
  end

  context 'palindrome index' do
    it 'returns 3 of palindrome index' do
      input = 'aaab'

      p = PalindromeIndex.new(input)

      expect(p.palindrome_index).to be 3
    end

    it 'returns 0 of palindrome index' do
      input = 'baa'

      p = PalindromeIndex.new(input)

      expect(p.palindrome_index).to be 0
    end

    it 'returns -1 of palindrome index' do
      input = 'aaa'

      p = PalindromeIndex.new(input)

      expect(p.palindrome_index).to be -1
    end

    it 'returns 1 of palindrome index' do
      input = 'quyjjdcgsvvsgcdjjyq'

      p = PalindromeIndex.new(input)

      expect(p.palindrome_index).to be 1
    end
  end
end
