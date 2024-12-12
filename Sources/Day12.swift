import Algorithms

private struct Pair: Hashable {
  let row: Int
  let col: Int
}

struct Day12: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  let grid: [[Character]]

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
    grid = self.data.components(separatedBy: "\n").map { line in
      Array(line)
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var numFenceBoundaries: [[Int?]] = Array(
      repeating: Array(repeating: nil, count: grid[0].count), count: grid.count)
    var regions: [Set<Pair>] = []
    var positionStack: [Pair] = []
    for row in 0..<grid.count {
      for col in 0..<grid[row].count {
        if numFenceBoundaries[row][col] == nil {
          var newRegion: Set<Pair> = Set()
          positionStack.append(Pair(row: row, col: col))
          while let position = positionStack.popLast() {
            newRegion.insert(position)
            numFenceBoundaries[position.row][position.col] = 0
            let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
            for direction in directions {
              let adjacent = (position.row + direction.0, position.col + direction.1)
              if grid[safe: adjacent.0]?[safe: adjacent.1] != grid[row][col] {
                numFenceBoundaries[position.row][position.col]! += 1
              } else {
                if numFenceBoundaries[adjacent.0][adjacent.1] == nil {
                  positionStack.append(Pair(row: adjacent.0, col: adjacent.1))
                }
              }
            }
          }
          regions.append(newRegion)
        }
      }
    }

    let totalPrice = regions.map { region in
      region.map { position in
        numFenceBoundaries[position.row][position.col]! * region.count
      }.reduce(0, +)
    }.reduce(0, +)

    return totalPrice
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var numFenceCorners: [[Int?]] = Array(
      repeating: Array(repeating: nil, count: grid[0].count), count: grid.count)
    var regions: [Set<Pair>] = []
    var positionStack: [Pair] = []
    for row in 0..<grid.count {
      for col in 0..<grid[row].count {
        if numFenceCorners[row][col] == nil {
          var newRegion: Set<Pair> = Set()
          positionStack.append(Pair(row: row, col: col))
          while let position = positionStack.popLast() {
            newRegion.insert(position)
            let directions = [(-1, 0), (0, -1), (1, 0), (0, 1)]
            for direction in directions {
              let adjacent = (position.row + direction.0, position.col + direction.1)
              if grid[safe: adjacent.0]?[safe: adjacent.1] == grid[row][col]
                && numFenceCorners[adjacent.0][adjacent.1] == nil
              {
                positionStack.append(Pair(row: adjacent.0, col: adjacent.1))
              }
            }

            numFenceCorners[position.row][position.col] = 0
            for rowdelta in [-1, 1] {
              for coldelta in [-1, 1] {
                if (grid[safe: position.row + rowdelta]?[safe: position.col] != grid[row][col]
                  && grid[safe: position.row]?[safe: position.col + coldelta] != grid[row][col])
                  || (grid[safe: position.row + rowdelta]?[safe: position.col] == grid[row][col]
                    && grid[safe: position.row]?[safe: position.col + coldelta] == grid[row][col]
                    && grid[safe: position.row + rowdelta]?[safe: position.col + coldelta]
                      != grid[row][col])
                {
                  numFenceCorners[position.row][position.col]! += 1
                }
              }
            }
          }
          regions.append(newRegion)
        }
      }
    }

    let totalPrice = regions.map { region in
      region.map { position in
        numFenceCorners[position.row][position.col]! * region.count
      }.reduce(0, +)
    }.reduce(0, +)

    return totalPrice
  }
}
