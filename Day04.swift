import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

let lines = try String(contentsOfFile: "./Inputs/Day04.txt", encoding: .utf8)
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .components(separatedBy: "\n")

func checkDirection(
    needle: String, haystack: [[Character]], start: (Int, Int), direction: (Int, Int)
) -> Bool {
    return needle.enumerated().allSatisfy { (index, character) in
        haystack[safe: start.0 + index * direction.0]?[safe: start.1 + index * direction.1]
            == character
    }
}

let grid = lines.map { line in [Character](line) }

var numFound = 0
for (row, line) in grid.enumerated() {
    for (col, _) in line.enumerated() {
        numFound +=
            checkDirection(needle: "XMAS", haystack: grid, start: (row, col), direction: (0, 1))
            ? 1 : 0
        numFound +=
            checkDirection(needle: "XMAS", haystack: grid, start: (row, col), direction: (0, -1))
            ? 1 : 0
        numFound +=
            checkDirection(needle: "XMAS", haystack: grid, start: (row, col), direction: (1, 0))
            ? 1 : 0
        numFound +=
            checkDirection(needle: "XMAS", haystack: grid, start: (row, col), direction: (-1, 0))
            ? 1 : 0
        numFound +=
            checkDirection(needle: "XMAS", haystack: grid, start: (row, col), direction: (1, 1))
            ? 1 : 0
        numFound +=
            checkDirection(needle: "XMAS", haystack: grid, start: (row, col), direction: (-1, 1))
            ? 1 : 0
        numFound +=
            checkDirection(needle: "XMAS", haystack: grid, start: (row, col), direction: (1, -1))
            ? 1 : 0
        numFound +=
            checkDirection(needle: "XMAS", haystack: grid, start: (row, col), direction: (-1, -1))
            ? 1 : 0

    }
}

print("Part One: \(numFound)")

numFound = 0

for (row, line) in grid.enumerated() {
    for (col, _) in line.enumerated() {
        numFound +=
            checkDirection(
                needle: "MAS", haystack: grid, start: (row - 1, col - 1), direction: (1, 1))
                && checkDirection(
                    needle: "MAS", haystack: grid, start: (row - 1, col + 1), direction: (1, -1))
            ? 1 : 0
        numFound +=
            checkDirection(
                needle: "MAS", haystack: grid, start: (row + 1, col - 1), direction: (-1, 1))
                && checkDirection(
                    needle: "MAS", haystack: grid, start: (row - 1, col + 1), direction: (1, -1))
            ? 1 : 0
        numFound +=
            checkDirection(
                needle: "MAS", haystack: grid, start: (row - 1, col - 1), direction: (1, 1))
                && checkDirection(
                    needle: "MAS", haystack: grid, start: (row + 1, col + 1), direction: (-1, -1))
            ? 1 : 0
        numFound +=
            checkDirection(
                needle: "MAS", haystack: grid, start: (row + 1, col - 1), direction: (-1, 1))
                && checkDirection(
                    needle: "MAS", haystack: grid, start: (row + 1, col + 1), direction: (-1, -1))
            ? 1 : 0
        numFound +=
            checkDirection(
                needle: "MAS", haystack: grid, start: (row - 1, col - 1), direction: (1, 1))
                && checkDirection(
                    needle: "MAS", haystack: grid, start: (row + 1, col - 1), direction: (-1, 1))
            ? 1 : 0
        numFound +=
            checkDirection(
                needle: "MAS", haystack: grid, start: (row - 1, col + 1), direction: (1, -1))
                && checkDirection(
                    needle: "MAS", haystack: grid, start: (row + 1, col + 1), direction: (-1, -1))
            ? 1 : 0
    }
}

print("Part Two: \(numFound)")
