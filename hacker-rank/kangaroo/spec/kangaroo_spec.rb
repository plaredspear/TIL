require 'kangaroo'

RSpec.describe Kangaroo do
  context '#solve' do
    it '0 2 5 3' do
      expect(Kangaroo.solve(0, 2, 5, 3)).to be false
    end

    it '0 3 4 2' do
      expect(Kangaroo.solve(0, 3, 4, 2)).to be true
    end

    it '21 6 47 3' do
      expect(Kangaroo.solve(21, 6, 47, 3)).to be false
    end
  end
end
