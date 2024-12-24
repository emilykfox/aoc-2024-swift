import Collections
import Foundation

private struct Location: Hashable {
  let row: Int
  let col: Int
}

struct Day20: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String

  private let map: [[Character]]
  private let start: Location
  private let end: Location

  private static let savingsThreshold: Int = 100

  init(data: String) {
    // paste hardcoded examples here
    /*let data = """
      ###############
      #...#...#.....#
      #.#.#.#.#.###.#
      #S#...#.#.#...#
      #######.#.#.###
      #######.#.#...#
      #######.#.###.#
      ###..E#...#...#
      ###.#######.###
      #...###...#...#
      #.#####.#.###.#
      #.#...#.#.#...#
      #.#.#.#.#.#.###
      #...#...#...###
      ###############
      """*/

    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)

    var start: Location? = nil
    var end: Location? = nil
    self.map = self.data.components(separatedBy: "\n").enumerated().map { (row, line) in
      line.enumerated().map { (col, character) in
        if character == "S" {
          start = Location(row: row, col: col)
          return "." as Character
        } else if character == "E" {
          end = Location(row: row, col: col)
          return "." as Character
        } else {
          return character
        }
      }
    }
    self.start = start!
    self.end = end!
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var distances: [[Int?]] = Array(
      repeating: Array(repeating: nil, count: map.count), count: map[0].count)
    distances[end.row][end.col] = 0

    var queue = Deque([end])
    while let to = queue.popFirst() {
      let deltas = [(1, 0), (-1, 0), (0, 1), (0, -1)]
      for delta in deltas {
        let from = Location(row: to.row - delta.0, col: to.col - delta.1)
        if map[from.row][from.col] != "#" && distances[from.row][from.col] == nil {
          distances[from.row][from.col] = distances[to.row][to.col]! + 1
          queue.append(from)
        }
      }
    }

    var numGoodCheats = 0
    for row in 0..<map.count {
      for col in 0..<map[row].count {
        for delta in [(2, 0), (-2, 0), (0, 2), (0, -2), (1, 1), (1, -1), (-1, 1), (-1, -1)] {
          let toRow = row + delta.0
          let toCol = col + delta.1
          if let fromDist = distances[row][col] {
            if let toDist = distances[safe: toRow]?[safe: toCol] ?? nil {
              if fromDist - toDist - 2 >= Day20.savingsThreshold {
                numGoodCheats += 1
              }
            }
          }
        }
      }
    }

    return numGoodCheats
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var distances: [[Int?]] = Array(
      repeating: Array(repeating: nil, count: map.count), count: map[0].count)
    distances[end.row][end.col] = 0

    var queue = Deque([end])
    while let to = queue.popFirst() {
      let deltas = [(1, 0), (-1, 0), (0, 1), (0, -1)]
      for delta in deltas {
        let from = Location(row: to.row - delta.0, col: to.col - delta.1)
        if map[from.row][from.col] != "#" && distances[from.row][from.col] == nil {
          distances[from.row][from.col] = distances[to.row][to.col]! + 1
          queue.append(from)
        }
      }
    }

    var numGoodCheats = 0
    for row in 0..<map.count {
      for col in 0..<map[row].count {
        for deltaHor in -20...20 {
          for deltaCol in -20...20 {
            let timeCheating = abs(deltaHor) + abs(deltaCol)
            if timeCheating <= 20 {
              let toRow = row + deltaHor
              let toCol = col + deltaCol
              if let fromDist = distances[row][col] {
                if let toDist = distances[safe: toRow]?[safe: toCol] ?? nil {
                  if fromDist - toDist - timeCheating >= Day20.savingsThreshold {
                    numGoodCheats += 1
                  }
                }
              }
            }
          }
        }
      }
    }

    return numGoodCheats
  }
}
