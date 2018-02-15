require 'grading_student'

RSpec.describe GradingStudent do
  context '#solve' do
    it 'solves 73 grade' do
      grade = 73
      expect(GradingStudent.solve(grade)).to eq(75)
    end

    it 'solves 67 grade' do
      grade = 67
      expect(GradingStudent.solve(grade)).to eq(67)
    end

    it 'solves 38 grade' do
      grade = 38
      expect(GradingStudent.solve(grade)).to eq(40)
    end

    it 'solves 33 grade' do
      grade = 33
      expect(GradingStudent.solve(grade)).to eq(33)
    end

    it '' do
      input  = [80,96,18,73,78,60,60,15,45,15,10,5,46,87,33,60,14,71,65,2,5,97,0]
      output = [80,96,18,75,80,60,60,15,45,15,10,5,46,87,33,60,14,71,65,2,5,97,0]

      input.each_with_index do |grade, index|
        expect(GradingStudent.solve(grade)).to eq(output[index])
      end
    end
  end
end
