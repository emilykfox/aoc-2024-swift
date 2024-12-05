import Algorithms

extension Array {
  subscript(safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String
  var grid: [[Character]]

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
    grid = data.split(separator: "\n").map { [Character]($0) }
  }

  func checkDirection(
    needle: String, start: (Int, Int), direction: (Int, Int)
  ) -> Bool {
    return needle.enumerated().allSatisfy { (index, character) in
      grid[safe: start.0 + index * direction.0]?[safe: start.1 + index * direction.1]
        == character
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var numFound = 0
    for (row, line) in grid.enumerated() {
      for (col, _) in line.enumerated() {
        numFound +=
          checkDirection(needle: "XMAS", start: (row, col), direction: (0, 1))
          ? 1 : 0
        numFound +=
          checkDirection(needle: "XMAS", start: (row, col), direction: (0, -1))
          ? 1 : 0
        numFound +=
          checkDirection(needle: "XMAS", start: (row, col), direction: (1, 0))
          ? 1 : 0
        numFound +=
          checkDirection(needle: "XMAS", start: (row, col), direction: (-1, 0))
          ? 1 : 0
        numFound +=
          checkDirection(needle: "XMAS", start: (row, col), direction: (1, 1))
          ? 1 : 0
        numFound +=
          checkDirection(needle: "XMAS", start: (row, col), direction: (-1, 1))
          ? 1 : 0
        numFound +=
          checkDirection(needle: "XMAS", start: (row, col), direction: (1, -1))
          ? 1 : 0
        numFound +=
          checkDirection(needle: "XMAS", start: (row, col), direction: (-1, -1))
          ? 1 : 0
      }
    }

    return numFound
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() throws -> Any {

    var numFound = 0

    for (row, line) in grid.enumerated() {
      for (col, _) in line.enumerated() {
        numFound +=
          checkDirection(
            needle: "MAS", start: (row - 1, col - 1), direction: (1, 1))
            && checkDirection(
              needle: "MAS", start: (row - 1, col + 1), direction: (1, -1))
          ? 1 : 0
        numFound +=
          checkDirection(
            needle: "MAS", start: (row + 1, col - 1), direction: (-1, 1))
            && checkDirection(
              needle: "MAS", start: (row - 1, col + 1), direction: (1, -1))
          ? 1 : 0
        numFound +=
          checkDirection(
            needle: "MAS", start: (row - 1, col - 1), direction: (1, 1))
            && checkDirection(
              needle: "MAS", start: (row + 1, col + 1), direction: (-1, -1))
          ? 1 : 0
        numFound +=
          checkDirection(
            needle: "MAS", start: (row + 1, col - 1), direction: (-1, 1))
            && checkDirection(
              needle: "MAS", start: (row + 1, col + 1), direction: (-1, -1))
          ? 1 : 0
        numFound +=
          checkDirection(
            needle: "MAS", start: (row - 1, col - 1), direction: (1, 1))
            && checkDirection(
              needle: "MAS", start: (row + 1, col - 1), direction: (-1, 1))
          ? 1 : 0
        numFound +=
          checkDirection(
            needle: "MAS", start: (row - 1, col + 1), direction: (1, -1))
            && checkDirection(
              needle: "MAS", start: (row + 1, col + 1), direction: (-1, -1))
          ? 1 : 0
      }
    }
    return numFound
  }
}
