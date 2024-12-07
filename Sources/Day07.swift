import Algorithms

private struct Equation {
  let lhs: Int
  let rhs: [Int]
}

struct Day07: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  private let equations: [Equation]

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
    self.equations = self.data.components(separatedBy: "\n").map { line in
      let sides = line.components(separatedBy: ": ")
      let lhs = Int(sides[0])!
      let rhs = sides[1].components(separatedBy: " ").map { Int($0)! }
      return Equation(lhs: lhs, rhs: rhs)
    }
  }

  private func makeLHS(goal: Int, rhs: [Int], lastIndex: Int) -> Bool {
    if lastIndex == 0 {
      return goal == rhs[lastIndex]
    }
    if goal % rhs[lastIndex] == 0
      && makeLHS(goal: goal / rhs[lastIndex], rhs: rhs, lastIndex: lastIndex - 1)
    {
      return true
    }
    return makeLHS(goal: goal - rhs[lastIndex], rhs: rhs, lastIndex: lastIndex - 1)
  }

  private func makeLHSConcat(goal: Int, rhs: [Int], lastIndex: Int) throws -> Bool {
    if lastIndex == 0 {
      return goal == rhs[lastIndex]
    }
    let regex = try Regex("(-?\\d+)\(rhs[lastIndex])$")
    let match = String(goal).firstMatch(of: regex)
    if let match {
      let substring = match[1].substring!
      if try makeLHSConcat(
        goal: Int(substring)!, rhs: rhs, lastIndex: lastIndex - 1)
      {
        return true
      }
    }
    if try goal % rhs[lastIndex] == 0
      && makeLHSConcat(goal: goal / rhs[lastIndex], rhs: rhs, lastIndex: lastIndex - 1)
    {
      return true
    }
    return try makeLHSConcat(goal: goal - rhs[lastIndex], rhs: rhs, lastIndex: lastIndex - 1)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var total = 0
    equationLoop: for equation in self.equations {
      if makeLHS(goal: equation.lhs, rhs: equation.rhs, lastIndex: equation.rhs.count - 1) {
        total += equation.lhs
      }
    }

    return total
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() throws -> Any {
    var total = 0
    equationLoop: for equation in self.equations {
      if try makeLHSConcat(goal: equation.lhs, rhs: equation.rhs, lastIndex: equation.rhs.count - 1)
      {
        total += equation.lhs
      }
    }

    return total
  }
}
