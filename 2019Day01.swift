import Foundation

let lines = try String(contentsOfFile: "./Inputs/2019Day01.txt", encoding: .utf8).components(
  separatedBy: "\n")

var masses: [Int] = []
for line in lines {
  masses.append(Int(line)!)
}

var answerOne = 0
for mass in masses {
  answerOne += mass / 3 - 2
}

print("Part One: \(answerOne)")

var answerTwo = 0
for mass in masses {
  var fuel = mass / 3 - 2
  while fuel > 0 {
    answerTwo += fuel
    fuel = fuel / 3 - 2
  }
}

print("Part Two: \(answerTwo)")
