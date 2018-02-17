class Problem
  def self.solve(a)
    i = 0

    str = self.reduce_pair(a, i)

    if str.empty?
      "Empty String"
    else
      str
    end
  end

  def self.reduce_pair(str, i)
    return str if i + 2 > str.length

    i = 0 if i < 0

    if str[i] == str[i+1]
      reduced = str[0...i] + str[(i+2)...str.length]
      self.reduce_pair(reduced, i - 1)
    else
      self.reduce_pair(str, i + 1)
    end
  end
end
