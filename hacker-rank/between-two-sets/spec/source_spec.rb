require 'source'

RSpec.describe Problem do
  context '#' do
    it 'a = [2,4], b = [16,32,96]' do
      a = [2, 4]
      b = [16, 32, 96]
      expect(Problem.solve(a, b)).to eq(3)
    end
  end
end
