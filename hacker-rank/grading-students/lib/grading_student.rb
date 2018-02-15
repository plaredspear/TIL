class GradingStudent
  def self.solve(grade)
    return grade if grade < 38

    reminder = grade % 5

    if (5 - reminder) < 3
      (grade - reminder) + 5
    elsif (5 - reminder) >= 3
      grade
    else
      puts 'error : ' + grade.to_s
    end
  end
end
