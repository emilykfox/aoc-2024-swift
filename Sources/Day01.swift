import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var leftNums: [Int] = []
    var rightNums: [Int] = []

    data.split(separator: "\n").forEach {
      let matches = $0.wholeMatch(of: #/(\d{5})   (\d{5})/#)!
      let left = Int(matches.1)!
      let right = Int(matches.2)!
      leftNums.append(left)
      rightNums.append(right)
    }

    leftNums.sort()
    rightNums.sort()
    var sum = 0
    for index in 0..<leftNums.count {
      sum += abs(leftNums[index] - rightNums[index])
    }

    return sum
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var leftNums: [Int] = []
    var rightCounts: [Int: Int] = [:]

    data.split(separator: "\n").forEach {
      let matches = $0.wholeMatch(of: #/(\d{5})   (\d{5})/#)!
      let left = Int(matches.1)!
      let right = Int(matches.2)!
      leftNums.append(left)
      rightCounts[right, default: 0] += 1
    }

    var sum = 0
    for num in leftNums {
      sum += num * (rightCounts[num] ?? 0)
    }

    return sum
  }
}
