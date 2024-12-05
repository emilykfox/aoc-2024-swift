import Algorithms

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {

    let matches = data.matches(of: #/mul\((\d\d?\d?),(\d\d?\d?)\)/#)

    var sum = 0
    for match in matches {
      sum += Int(match.1)! * Int(match.2)!
    }

    return sum
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() throws -> Any {

    let matchesB = data.matches(
      of: #/(mul\((\d\d?\d?),(\d\d?\d?)\))|(do\(\))|(don\'t\(\))/#)
    var enabled = true
    var sum = 0
    for match in matchesB {
      if match.4 != nil {
        enabled = true
        continue
      } else if match.5 != nil {
        enabled = false
        continue
      } else if enabled {
        sum += Int(match.2!)! * Int(match.3!)!
      }

    }

    return sum
  }
}
