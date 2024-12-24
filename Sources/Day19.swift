import Collections
import Foundation

private struct Location: Hashable {
  let row: Int
  let col: Int
}

struct Day19: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String

  let towels: [[Character]]
  let designs: [[Character]]

  init(data: String) {
    // paste hardcoded examples here
    /*let data = """
      r, wr, b, g, bwu, rb, gb, br

      brwrr
      bggr
      gbbr
      rrbgbr
      ubwu
      bwurrg
      brgr
      bbrgwb
      """*/

    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)

    let components = self.data.components(separatedBy: "\n\n")
    towels = components[0].components(separatedBy: [","]).map {
      Array($0.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    designs = components[1].components(separatedBy: "\n").map { Array($0) }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var numPossible = 0
    for design in designs {
      var canMake = Array(repeating: true, count: design.count + 1)
      for from in (0..<design.count).reversed() {
        canMake[from] = towels.contains { towel in
          design[from...].starts(with: towel) && canMake[from + towel.count]
        }
      }
      if canMake[0] {
        numPossible += 1
      }
    }
    return numPossible
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var numWays = 0
    for design in designs {
      var ways = Array(repeating: 1, count: design.count + 1)
      for from in (0..<design.count).reversed() {
        ways[from] = towels.map { towel in
          if design[from...].starts(with: towel) {
            return ways[from + towel.count]
          } else {
            return 0
          }
        }.reduce(0, +)
      }
      numWays += ways[0]
    }
    return numWays
  }
}
