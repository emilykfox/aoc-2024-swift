import Foundation

let instructions = try String(contentsOfFile: "./Inputs/Day03.txt", encoding: .utf8)
  .trimmingCharacters(in: .whitespacesAndNewlines)

let matches = instructions.matches(of: #/mul\((\d\d?\d?),(\d\d?\d?)\)/#)

var sumOne = 0
for match in matches {
  sumOne += Int(match.1)! * Int(match.2)!
}

let matchesB = instructions.matches(of: #/(mul\((\d\d?\d?),(\d\d?\d?)\))|(do\(\))|(don\'t\(\))/#)
var enabled = true
var sumTwo = 0
for match in matchesB {
  if match.4 != nil {
    enabled = true
    continue
  } else if match.5 != nil {
    enabled = false
    continue
  } else if enabled {
    sumTwo += Int(match.2!)! * Int(match.3!)!
  }

}

print("Part One: \(sumOne)")

print("Part Two: \(sumTwo)")
