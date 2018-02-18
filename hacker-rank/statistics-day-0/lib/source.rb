class Problem
  def self.mean(n, arr)
    (arr.reduce(:+) / n.to_f).round(1)
  end

  def self.median(n, arr)
    if n.odd?
      (arr[n / 2].to_f).round(1)
    else
      ((arr.sort[n/2 - 1] + arr.sort[n/2])/2.to_f).round(1)
    end
  end

  def self.mode(n, arr)
    arr_hash = {}
    arr.sort.each do |e|
      if arr_hash[e].nil?
        arr_hash[e] = 1
      else
        arr_hash[e] += 1
      end
    end

    arr_hash.max_by { |k, v| v }[0]
  end
end
