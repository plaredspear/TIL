require 'source'

RSpec.describe Problem do
  context '#' do
    it "reduces a 'aa'" do
      str = 'a'
      expect(Problem.solve(str)).to eq('a')
    end

    it "reduces a 'aa'" do
      str = 'aa'
      expect(Problem.solve(str)).to eq('Empty String')
    end

    it "reduces a 'aa'" do
      str = 'ab'
      expect(Problem.solve(str)).to eq('ab')
    end

    it "reduces a 'baa'" do
      str = 'aab'
      expect(Problem.solve(str)).to eq('b')
    end

    it "reduces a 'baa'" do
      str = 'baa'
      expect(Problem.solve(str)).to eq('b')
    end

    it "reduces a 'aab'" do
      str = 'aab'
      expect(Problem.solve(str)).to eq('b')
    end

    it "reduces a 'baab'" do
      str = 'baab'
      expect(Problem.solve(str)).to eq('Empty String')
    end

    it "reduces a 'ababaa'" do
      str = 'ababaa'
      expect(Problem.solve(str)).to eq('abab')
    end

    it "reduces a 'aaabccddd'" do
      str = 'aaabccddd'
      expect(Problem.solve(str)).to eq('abd')
    end
  end
end
