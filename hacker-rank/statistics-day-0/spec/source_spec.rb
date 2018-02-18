require 'source'

RSpec.describe Problem do
  context '#' do
    it '' do
      file = File.new("spec/input.txt")
      n = file.gets.to_i
      puts n

      arr = file.gets.split(' ').map(&:to_i)

      expect(Problem.mean(n, arr)).to eq 49921.5
      expect(Problem.median(n, arr)).to eq 49253.5
      expect(Problem.mode(n, arr)).to eq 2184
    end
  end
end
