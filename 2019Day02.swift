import Foundation

let numbers = try String(contentsOfFile: "./Inputs/2019Day02.txt", encoding: .utf8)
  .trimmingCharacters(in: .whitespacesAndNewlines).components(
    separatedBy: ",")

let initialMemory = numbers.map { Int($0)! }

var memory = initialMemory

memory[1] = 12
memory[2] = 2

opLoop: for index in 0..<memory.count / 4 {
  let code = memory[4 * index]
  switch code {
  case 1:
    memory[memory[4 * index + 3]] =
      memory[memory[4 * index + 1]] + memory[memory[4 * index + 2]]
  case 2:
    memory[memory[4 * index + 3]] =
      memory[memory[4 * index + 1]] * memory[memory[4 * index + 2]]
  default: break opLoop
  }
}

let answerOne = memory[0]

print("Part One: \(answerOne)")

var answerTwo = 0
nounLoop: for noun in 0...99 {
  for verb in 0...99 {
    var memory = initialMemory
    memory[1] = noun
    memory[2] = verb

    opLoop: for index in 0..<memory.count / 4 {
      let code = memory[4 * index]
      switch code {
      case 1:
        memory[memory[4 * index + 3]] =
          memory[memory[4 * index + 1]] + memory[memory[4 * index + 2]]
      case 2:
        memory[memory[4 * index + 3]] =
          memory[memory[4 * index + 1]] * memory[memory[4 * index + 2]]
      default: break opLoop
      }
    }

    if memory[0] == 19_690_720 {
      answerTwo = 100 * noun + verb
      break nounLoop
    }
  }
}

print("Part Two: \(answerTwo)")
