import Algorithms

private struct Pair: Hashable {
  let row: Int
  let col: Int
}

struct Day10: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  let heights: [[Int]]

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
    heights = self.data.components(separatedBy: "\n").enumerated().map { (row, line) in
      line.enumerated().map { (col, character) in
        character.wholeNumberValue!
      }
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var canReach = (0..<heights.count).map { row in
      (0..<heights[row].count).map { col in
        if heights[row][col] == 9 { Set([Pair(row: row, col: col)]) } else { Set<Pair>() }
      }
    }

    for currentHeight in (0...8).reversed() {
      for row in 0..<heights.count {
        for col in 0..<heights[row].count {
          if heights[row][col] == currentHeight {
            for (colDelta, rowDelta) in [(-1, 0), (1, 0), (0, 1), (0, -1)] {
              if heights[safe: row + rowDelta]?[safe: col + colDelta] == currentHeight + 1 {
                canReach[row][col].formUnion(canReach[row + rowDelta][col + colDelta])
              }
            }
          }
        }
      }
    }

    var sum = 0
    for row in 0..<heights.count {
      for col in 0..<heights[row].count {
        if heights[row][col] == 0 {
          sum += canReach[row][col].count
        }
      }
    }
    return sum
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var ratings = heights.map { row in row.map { height in if height == 9 { 1 } else { 0 } } }

    for currentHeight in (0...8).reversed() {
      for row in 0..<heights.count {
        for col in 0..<heights[row].count {
          if heights[row][col] == currentHeight {
            for (colDelta, rowDelta) in [(-1, 0), (1, 0), (0, 1), (0, -1)] {
              if heights[safe: row + rowDelta]?[safe: col + colDelta] == currentHeight + 1 {
                ratings[row][col] += ratings[row + rowDelta][col + colDelta]
              }
            }
          }
        }
      }
    }

    var sum = 0
    for row in 0..<heights.count {
      for col in 0..<heights[row].count {
        if heights[row][col] == 0 {
          sum += ratings[row][col]
        }
      }
    }
    return sum
  }
}
