import Algorithms

private struct Pair: Hashable {
  let x: Int
  let y: Int
}

private struct Walked: Hashable {
  let pair: Pair
  let direction: String
}

struct Day06: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  var grid: [[Character]]
  var start: (Int, Int)

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
    var start = (0, 0)
    grid = data.components(separatedBy: "\n").enumerated().map { (row, line) in
      line.enumerated().map { (col, character) in
        if character == "^" {
          start = (row, col)
        }
        return character
      }
    }
    self.start = start
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var current = start
    var direction = "^"
    var visited: Set<Pair> = []
    while true {
      visited.insert(Pair(x: current.0, y: current.1))
      let next =
        switch direction {
        case "^": (current.0 - 1, current.1)
        case "<": (current.0, current.1 - 1)
        case "v": (current.0 + 1, current.1)
        default: (current.0, current.1 + 1)
        }
      if grid[safe: next.0]?[safe: next.1] == nil {
        break
      }
      if grid[safe: next.0]?[safe: next.1] == "#" {
        direction =
          switch direction {
          case "^": ">"
          case "<": "^"
          case "v": "<"
          default: "v"
          }
      } else {
        current = next
      }
    }

    return visited.count
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() throws -> Any {
    var total = 0
    // takes about 12 seconds to run in release mode on an M2 Pro
    for row in 0..<grid.count {
      for col in 0..<grid[0].count {

        var current = start
        var direction = "^"
        var allWalked: Set<Walked> = Set()
        while true {
          let walked = Walked(pair: Pair(x: current.0, y: current.1), direction: direction)
          if allWalked.contains(walked) {
            total += 1
            break
          } else {
            allWalked.insert(walked)
          }
          let next =
            switch direction {
            case "^": (current.0 - 1, current.1)
            case "<": (current.0, current.1 - 1)
            case "v": (current.0 + 1, current.1)
            default: (current.0, current.1 + 1)
            }
          if grid[safe: next.0]?[safe: next.1] == nil {
            break
          }
          if grid[safe: next.0]?[safe: next.1] == "#" || (next.0 == row && next.1 == col) {
            direction =
              switch direction {
              case "^": ">"
              case "<": "^"
              case "v": "<"
              default: "v"
              }
          } else {
            current = next
          }
        }
      }
    }

    return total
  }
}
