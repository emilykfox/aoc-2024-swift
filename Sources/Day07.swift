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

  private func canMakeLHS(lhs: Int, aggregate: Int, rhs: [Int], firstIndex: Int) -> Bool {
    if firstIndex == rhs.count {
      return aggregate == lhs
    }
    return canMakeLHS(
      lhs: lhs, aggregate: aggregate + rhs[firstIndex], rhs: rhs, firstIndex: firstIndex + 1)
      || canMakeLHS(
        lhs: lhs, aggregate: aggregate * rhs[firstIndex], rhs: rhs, firstIndex: firstIndex + 1)
  }

  private func canMakeLHSConcat(lhs: Int, aggregate: Int, rhs: [Int], firstIndex: Int)
    -> Bool
  {
    if firstIndex == rhs.count {
      return aggregate == lhs
    }
    return canMakeLHSConcat(
      lhs: lhs, aggregate: aggregate + rhs[firstIndex], rhs: rhs, firstIndex: firstIndex + 1)
      || canMakeLHSConcat(
        lhs: lhs, aggregate: aggregate * rhs[firstIndex], rhs: rhs, firstIndex: firstIndex + 1)
      || canMakeLHSConcat(
        lhs: lhs, aggregate: Int(String(aggregate) + String(rhs[firstIndex]))!, rhs: rhs,
        firstIndex: firstIndex + 1)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var total = 0
    equationLoop: for equation in self.equations {
      if canMakeLHS(
        lhs: equation.lhs, aggregate: equation.rhs[0], rhs: equation.rhs, firstIndex: 1)
      {
        total += equation.lhs
      }
    }

    return total
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() throws -> Any {
    var total = 0
    equationLoop: for equation in self.equations {
      if canMakeLHSConcat(
        lhs: equation.lhs, aggregate: equation.rhs[0], rhs: equation.rhs, firstIndex: 1)
      {
        total += equation.lhs
      }
    }

    return total
  }
}
