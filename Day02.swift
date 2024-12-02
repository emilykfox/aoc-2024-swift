import Foundation

let reports = try String(contentsOfFile: "./Inputs/Day02.txt", encoding: .utf8)
  .trimmingCharacters(in: .whitespacesAndNewlines).components(
    separatedBy: "\n")

var numSafe = 0
for report in reports {
  let levels = report.components(separatedBy: " ").map { Int($0)! }
  let increasing = levels[1] > levels[0]
  var safe = true
  for index in 0..<levels.count - 1 {
    safe =
      safe
      && ((increasing && levels[index + 1] > levels[index] && levels[index + 1] < levels[index] + 4)
        || (!increasing && levels[index + 1] < levels[index]
          && levels[index + 1] > levels[index] - 4))
  }
  if safe {
    numSafe += 1
  }
}

print("Part One: \(numSafe)")

numSafe = 0

reportLoop: for report in reports {
  let levels = report.components(separatedBy: " ").map { Int($0)! }
  let increasing = levels[1] > levels[0]
  var safe = true
  for index in 0..<levels.count - 1 {
    safe =
      safe
      && ((increasing && levels[index + 1] > levels[index] && levels[index + 1] < levels[index] + 4)
        || (!increasing && levels[index + 1] < levels[index]
          && levels[index + 1] > levels[index] - 4))
  }
  if safe {
    numSafe += 1
    continue reportLoop
  }
  for skip in 0..<levels.count {
    var saferLevels = levels
    saferLevels.remove(at: skip)
    let increasing = saferLevels[1] > saferLevels[0]
    var safe = true
    for index in 0..<saferLevels.count - 1 {
      safe =
        safe
        && ((increasing && saferLevels[index + 1] > saferLevels[index]
          && saferLevels[index + 1] < saferLevels[index] + 4)
          || (!increasing && saferLevels[index + 1] < saferLevels[index]
            && saferLevels[index + 1] > saferLevels[index] - 4))
    }
    if safe {
      numSafe += 1
      continue reportLoop
    }
  }
}

print("Part Two: \(numSafe)")
