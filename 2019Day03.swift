import Foundation

struct Pair: Hashable {
  let x: Int
  let y: Int
}

extension String: @retroactive Error {}

let instructionSets = try String(contentsOfFile: "./Inputs/2019Day03.txt", encoding: .utf8)
  .trimmingCharacters(in: .whitespacesAndNewlines).components(
    separatedBy: "\n")

var lengthsA: [Pair: Int] = [:]
var lengthsB: [Pair: Int] = [:]

func fillTable(_ table: inout [Pair: Int], using instructions: String) throws {
  var currentPosition = Pair(x: 0, y: 0)
  var currentLength = 0
  for instruction in instructions.components(separatedBy: ",") {
    let match = instruction.firstMatch(of: #/(\w)(\d+)/#)!
    let distance = Int(match.2)!
    switch match.1 {
    case "R":
      for _ in 0..<distance {
        currentLength += 1
        currentPosition = Pair(x: currentPosition.x + 1, y: currentPosition.y)
        table[currentPosition] = currentLength
      }
    case "L":
      for _ in 0..<distance {
        currentLength += 1
        currentPosition = Pair(x: currentPosition.x - 1, y: currentPosition.y)
        table[currentPosition] = currentLength
      }
    case "U":
      for _ in 0..<distance {
        currentLength += 1
        currentPosition = Pair(x: currentPosition.x, y: currentPosition.y - 1)
        table[currentPosition] = currentLength
      }
    case "D":
      for _ in 0..<distance {
        currentLength += 1
        currentPosition = Pair(x: currentPosition.x, y: currentPosition.y + 1)
        table[currentPosition] = currentLength
      }
    default: throw "Bad direction!"
    }
  }
}

try fillTable(&lengthsA, using: instructionSets[0])
try fillTable(&lengthsB, using: instructionSets[1])

var minDistance = Int.max
var minLength = Int.max
for (position, lengthA) in lengthsA {
  if let lengthB = lengthsB[position] {
    let distance = abs(position.x) + abs(position.y)
    if distance < minDistance {
      minDistance = distance
    }
    let length = lengthA + lengthB
    if length < minLength {
      minLength = length
    }
  }
}

print("Part One: \(minDistance)")

print("Part Two: \(minLength)")
