import Foundation

let lines = try String(contentsOfFile: "./Inputs/Day01.txt", encoding: .utf8).components(
  separatedBy: "\n")

var leftNums: [Int] = []
var rightNums: [Int] = []
var rightCounts: [Int: Int] = [:]

for line in lines {
  let matches = line.wholeMatch(of: #/(\d{5})   (\d{5})/#)!
  let left = Int(matches.1)!
  let right = Int(matches.2)!
  leftNums.append(left)
  rightNums.append(right)
  rightCounts[right, default: 0] += 1
}

leftNums.sort()
rightNums.sort()
var sumOne = 0
for index in 0..<leftNums.count {
  sumOne += abs(leftNums[index] - rightNums[index])
}

print("Part One: \(sumOne)")

var sumTwo = 0
for num in leftNums {
  sumTwo += num * (rightCounts[num] ?? 0)
}

print("Part Two: \(sumTwo)")
