import Algorithms

private struct Pair: Hashable {
  let x: Int
  let y: Int
}

struct Day08: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  let grid: [[Character]]
  private var locations: [Character: [Pair]] = [:]

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
    grid = data.components(separatedBy: "\n").map { line in
      line.map { $0 }
    }

    for (row, line) in grid.enumerated() {
      for (col, character) in line.enumerated() {
        if character != "." {
          locations[character, default: []].append(Pair(x: col, y: row))
        }
      }
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var antinodes: Set<Pair> = Set()

    for positions in locations.values {
      for i in 0..<positions.count {
        for j in 0..<positions.count {
          if i == j {
            continue
          }
          let rowDiff = positions[j].y - positions[i].y
          let colDiff = positions[j].x - positions[i].x
          let (rowa, cola) = (positions[j].y + rowDiff, positions[j].x + colDiff)
          if 0 <= rowa && rowa < grid.count && 0 <= cola && cola < grid[0].count {
            antinodes.insert(Pair(x: cola, y: rowa))
          }
          let (rowb, colb) = (positions[i].y - rowDiff, positions[i].x - colDiff)
          if 0 <= rowb && rowb < grid.count && 0 <= colb && colb < grid[0].count {
            antinodes.insert(Pair(x: colb, y: rowb))
          }
        }
      }
    }

    return antinodes.count
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var antinodes: Set<Pair> = Set()

    for positions in locations.values {
      for i in 0..<positions.count {
        for j in 0..<positions.count {
          if i == j {
            continue
          }
          let rowDiff = positions[j].y - positions[i].y
          let colDiff = positions[j].x - positions[i].x
          for multiple in -grid.count...grid.count {
            let (rowa, cola) = (
              positions[j].y + multiple * rowDiff, positions[j].x + multiple * colDiff
            )
            if 0 <= rowa && rowa < grid.count && 0 <= cola && cola < grid[0].count {
              antinodes.insert(Pair(x: cola, y: rowa))
            }
          }
        }
      }
    }

    return antinodes.count
  }
}
