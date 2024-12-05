import Algorithms

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {

    var numSafe = 0
    for report in data.split(separator: "\n") {
      let levels = report.components(separatedBy: " ").map { Int($0)! }
      let increasing = levels[1] > levels[0]
      var safe = true
      for index in 0..<levels.count - 1 {
        safe =
          safe
          && ((increasing && levels[index + 1] > levels[index]
            && levels[index + 1] < levels[index] + 4)
            || (!increasing && levels[index + 1] < levels[index]
              && levels[index + 1] > levels[index] - 4))
      }
      if safe {
        numSafe += 1
      }
    }

    return numSafe
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() throws -> Any {

    var numSafe = 0
    reportLoop: for report in data.split(separator: "\n") {

      let levels = report.components(separatedBy: " ").map { Int($0)! }
      let increasing = levels[1] > levels[0]
      var safe = true
      for index in 0..<levels.count - 1 {
        safe =
          safe
          && ((increasing && levels[index + 1] > levels[index]
            && levels[index + 1] < levels[index] + 4)
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

    return numSafe
  }
}
