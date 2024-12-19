import Collections
import Foundation

private struct Location: Hashable {
  let row: Int
  let col: Int
}

private enum Instruction: Int {
  case adv = 0
  case bxl = 1
  case bst = 2
  case jnz = 3
  case bxc = 4
  case out = 5
  case bdv = 6
  case cdv = 7
}

struct Day17: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String

  private let initialA: Int
  private let initialB: Int
  private let initialC: Int
  private let program: [Int]

  init(data: String) {
    // paste hardcoded examples here
    /*let data = """
      Register A: 729
      Register B: 0
      Register C: 0

      Program: 0,1,5,4,3,0
      """*/
    /*let data = """
      Register A: 2024
      Register B: 0
      Register C: 0

      Program: 0,3,5,4,3,0
      """*/

    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)

    let lines = self.data.components(separatedBy: "\n")
    initialA = Int(lines[0].firstMatch(of: #/\d+$/#)!.0)!
    initialB = Int(lines[1].firstMatch(of: #/\d+$/#)!.0)!
    initialC = Int(lines[2].firstMatch(of: #/\d+$/#)!.0)!

    program = lines[4].components(separatedBy: " ")[1].components(separatedBy: ",").map { Int($0)! }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var a = initialA
    var b = initialB
    var c = initialC

    var outputs: [Int] = []

    func comboValue(of operand: Int) -> Int {
      switch operand {
      case 0...3: operand
      case 4: a
      case 5: b
      case 6: c
      default: 0
      }
    }

    var instructionPointer = 0
    while instructionPointer < program.count {
      let instruction = Instruction(rawValue: program[instructionPointer])!
      let operand = program[instructionPointer + 1]
      switch instruction {
      case .adv:
        a = a / Int(pow(Double(2), Double(comboValue(of: operand))))
      case .bxl: b = b ^ operand
      case .bst: b = comboValue(of: operand) % 8
      case .jnz:
        if a != 0 {
          instructionPointer = operand
          continue
        }
      case .bxc: b = b ^ c
      case .out: outputs.append(comboValue(of: operand) % 8)
      case .bdv:
        b = a / Int(pow(Double(2), Double(comboValue(of: operand))))
      case .cdv:
        c = a / Int(pow(Double(2), Double(comboValue(of: operand))))
      }

      instructionPointer += 2
    }

    return outputs.map { String($0) }.joined(separator: ",")
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var matchingPositions = 0
    var initialA = 0
    while true {
      var a = initialA
      var b = initialB
      var c = initialC

      var outputs: [Int] = []

      func comboValue(of operand: Int) -> Int {
        switch operand {
        case 0...3: operand
        case 4: a
        case 5: b
        case 6: c
        default: 0
        }
      }

      var instructionPointer = 0
      while instructionPointer < program.count {
        let instruction = Instruction(rawValue: program[instructionPointer])!
        let operand = program[instructionPointer + 1]
        switch instruction {
        case .adv:
          a = a >> comboValue(of: operand)
        // a = a / Int(pow(Double(2), Double(comboValue(of: operand))))
        case .bxl: b = b ^ operand
        case .bst: b = comboValue(of: operand) % 8
        case .jnz:
          if a != 0 {
            instructionPointer = operand
            continue
          }
        case .bxc: b = b ^ c
        case .out: outputs.append(comboValue(of: operand) % 8)
        case .bdv:
          b = a >> comboValue(of: operand)
        // b = a / Int(pow(Double(2), Double(comboValue(of: operand))))
        case .cdv:
          c = a >> comboValue(of: operand)
        // c = a / Int(pow(Double(2), Double(comboValue(of: operand))))
        }

        instructionPointer += 2
      }

      // appears to be a counter that prints in reverse
      if outputs.reversed()[0..<matchingPositions] != program.reversed()[0..<matchingPositions] {
        initialA += 1
      } else if matchingPositions == program.count {
        break
      } else {
        matchingPositions += 1
        initialA *= 8
      }
    }
    return initialA
  }
}
