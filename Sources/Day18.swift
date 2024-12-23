import Collections
import Foundation

private struct Location: Hashable {
  let row: Int
  let col: Int
}

struct Day18: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String

  private static let width: Int = 71
  private static let maxPushes: Int = 1024

  private let bytes: [Location]

  init(data: String) {
    // paste hardcoded examples here
    /*let data = """
      5,4
      4,2
      4,5
      3,0
      2,1
      6,3
      2,4
      1,5
      0,6
      3,3
      2,6
      5,1
      1,2
      5,5
      2,5
      6,5
      1,4
      0,4
      6,4
      1,1
      6,1
      1,0
      0,5
      1,6
      2,0
      """*/

    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
    bytes = self.data.components(separatedBy: "\n").map { line in
      let components = line.components(separatedBy: ",")
      return Location(row: Int(components[0])!, col: Int(components[1])!)
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var map: [[Character]] = Array(
      repeating: Array(repeating: ".", count: Day18.width), count: Day18.width)

    for location in bytes.prefix(Day18.maxPushes) {
      map[location.row][location.col] = "#"
    }

    let start = Location(row: 0, col: 0)
    let end = Location(row: Day18.width - 1, col: Day18.width - 1)
    var distances = Array(
      repeating: Array(repeating: Int.max, count: Day18.width), count: Day18.width)
    distances[start.row][start.col] = 0

    var queue = Deque([start])
    while let from = queue.popFirst() {
      for delta in [(1, 0), (-1, 0), (0, 1), (0, -1)] {
        let adjacent = Location(row: from.row + delta.0, col: from.col + delta.1)
        if map[safe: adjacent.row]?[safe: adjacent.col] == "."
          && distances[adjacent.row][adjacent.col] == Int.max
        {
          distances[adjacent.row][adjacent.col] = distances[from.row][from.col] + 1
          queue.append(adjacent)
        }
      }
    }

    return distances[end.row][end.col]
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var map: [[Character]] = Array(
      repeating: Array(repeating: ".", count: Day18.width), count: Day18.width)

    let start = Location(row: 0, col: 0)
    let end = Location(row: Day18.width - 1, col: Day18.width - 1)

    for byteLocation in bytes {
      map[byteLocation.row][byteLocation.col] = "#"
      var distances = Array(
        repeating: Array(repeating: Int.max, count: Day18.width), count: Day18.width)
      distances[start.row][start.col] = 0

      var queue = Deque([start])
      while let from = queue.popFirst() {
        for delta in [(1, 0), (-1, 0), (0, 1), (0, -1)] {
          let adjacent = Location(row: from.row + delta.0, col: from.col + delta.1)
          if map[safe: adjacent.row]?[safe: adjacent.col] == "."
            && distances[adjacent.row][adjacent.col] == Int.max
          {
            distances[adjacent.row][adjacent.col] = distances[from.row][from.col] + 1
            queue.append(adjacent)
          }
        }
      }

      if distances[end.row][end.col] == Int.max {
        return "\(byteLocation.row),\(byteLocation.col)"
      }
    }

    return "0,0"
  }
}
