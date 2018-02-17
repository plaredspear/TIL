class Kangaroo
  def self.solve(x1, v1, x2, v2)
    delta = (x2 - x1).to_f / (v1 - v2).to_f

    if delta % 1 == 0 and delta >= 0
      true
    else
      false
    end
  end
end
