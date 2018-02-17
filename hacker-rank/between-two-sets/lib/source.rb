class Problem
  def self.solve(a, b)
    lcm = a.reduce(&:lcm)

    avail = 0
    i = 1
    loop do
      if lcm * i > b.min
        break
      end

      avail += 1 if b.all? do |el_b|
        (el_b % (lcm * i)) == 0
      end

      i += 1
    end
    avail
  end
end
