import Algorithms

private struct Pair: Hashable {
  let row: Int
  let col: Int
}

struct Day11: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var stones = data.components(separatedBy: " ").map { Int($0)! }
    for _ in 0..<25 {
      stones = stones.flatMap { stone in
        if stone == 0 {
          return [1]
        }
        let stoneString = String(stone)
        let length = stoneString.count
        if length % 2 == 0 {
          return [Int(stoneString.prefix(length / 2))!, Int(stoneString.suffix(length / 2))!]
        }
        return [stone * 2024]
      }
    }

    return stones.count
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var stones: [Int: Int] = [:]
    for stoneString in data.components(separatedBy: " ") {
      stones[Int(stoneString)!, default: 0] += 1
    }
    for _ in 0..<75 {
      var newStones: [Int: Int] = [:]
      for (stone, count) in stones {
        if stone == 0 {
          newStones[1, default: 0] += count
          continue
        }
        let stoneString = String(stone)
        let length = stoneString.count
        if length % 2 == 0 {
          newStones[Int(stoneString.prefix(length / 2))!, default: 0] += count
          newStones[Int(stoneString.suffix(length / 2))!, default: 0] += count
          continue
        }
        newStones[stone * 2024, default: 0] += count
      }
      stones = newStones
    }

    return stones.values.reduce(0, +)
  }
}
