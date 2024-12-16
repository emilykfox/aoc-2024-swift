import Algorithms

private struct Location: Hashable {
  let row: Int
  let col: Int
}

struct Day15: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  let map: [[Character]]
  let start: (Int, Int)
  let directions: [Character]

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)

    // paste hardcoded examples here
    /*self.data = """
      ##########
      #..O..O.O#
      #......O.#
      #.OO..O.O#
      #..O@..O.#
      #O#..O...#
      #O..O..O.#
      #.OO.O.OO#
      #....O...#
      ##########

      <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
      vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
      ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
      <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
      ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
      ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
      >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
      <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
      ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
      v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
      """*/

    var start = (0, 0)
    let components = self.data.components(separatedBy: "\n\n")
    map = components[0].components(separatedBy: "\n").enumerated().map { (row, line) in
      line.enumerated().map { (col, character) in
        if character == "@" {
          start = (row, col)
        }
        return character
      }
    }
    self.start = start
    directions = Array(components[1])
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var currentMap = map
    var currentLocation = start
    for directionCharacter in directions {
      let direction =
        switch directionCharacter {
        case "^": (-1, 0)
        case ">": (0, 1)
        case "v": (1, 0)
        case "<": (0, -1)
        default: (0, 0)
        }
      if tryToPlace(
        character: "@", from: currentLocation, direction: direction, currentMap: &currentMap)
      {
        currentMap[currentLocation.0][currentLocation.1] = "."
        currentLocation.0 += direction.0
        currentLocation.1 += direction.1
      }
    }

    // Uncomment to see final map
    // print(String(currentMap.map { String($0) }.joined(by: "\n")))

    let sum = currentMap.enumerated().map { (rowIndex, row) in
      row.enumerated().map { (colIndex, character) in
        if character == "O" {
          100 * rowIndex + colIndex
        } else {
          0
        }
      }.reduce(0, +)
    }.reduce(0, +)

    return sum
  }

  func tryToPlace(
    character: Character, from: (Int, Int), direction: (Int, Int), currentMap: inout [[Character]]
  ) -> Bool {
    let target = (from.0 + direction.0, from.1 + direction.1)
    switch currentMap[target.0][target.1] {
    case "#": return false
    case "O":
      if !tryToPlace(
        character: "O", from: target, direction: direction, currentMap: &currentMap)
      {
        return false
      }
    default: ()
    }
    currentMap[target.0][target.1] = character
    return true
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var wideMap: [[Character]] = map.map { row in
      row.flatMap { character in
        let double: [Character] =
          switch character {
          case "O": ["[", "]"]
          case "@": ["@", "."]
          default: [character, character]
          }
        return double
      }
    }

    var currentLocation = (start.0, 2 * start.1)
    for directionCharacter in directions {
      let direction =
        switch directionCharacter {
        case "^": (-1, 0)
        case ">": (0, 1)
        case "v": (1, 0)
        case "<": (0, -1)
        default: (0, 0)
        }
      if tryToPlaceWide(
        character: "@", from: currentLocation, direction: direction, currentMap: &wideMap,
        dryRun: false)
      {
        wideMap[currentLocation.0][currentLocation.1] = "."
        currentLocation.0 += direction.0
        currentLocation.1 += direction.1
      }
    }

    // Uncomment to see final map
    // print(String(wideMap.map { String($0) }.joined(by: "\n")))

    let sum = wideMap.enumerated().map { (rowIndex, row) in
      row.enumerated().map { (colIndex, character) in
        if character == "[" {
          100 * rowIndex + colIndex
        } else {
          0
        }
      }.reduce(0, +)
    }.reduce(0, +)

    return sum
  }

  func tryToPlaceWide(
    character: Character, from: (Int, Int), direction: (Int, Int), currentMap: inout [[Character]],
    dryRun: Bool
  ) -> Bool {
    let target = (from.0 + direction.0, from.1 + direction.1)
    let atTarget = currentMap[target.0][target.1]
    switch atTarget {
    case "#": return false
    case "[" where direction == (1, 0) || direction == (-1, 0),
      "]" where direction == (1, 0) || direction == (-1, 0):
      let (otherTarget, otherCharacter): ((Int, Int), Character) =
        switch atTarget {
        case "[": ((target.0, target.1 + 1), "]")
        default: ((target.0, target.1 - 1), "[")
        }
      if tryToPlaceWide(
        character: atTarget, from: target, direction: direction, currentMap: &currentMap,
        dryRun: true)
        && tryToPlaceWide(
          character: otherCharacter, from: otherTarget, direction: direction,
          currentMap: &currentMap,
          dryRun: true)
      {
        if !dryRun {
          _ = tryToPlaceWide(
            character: atTarget, from: target, direction: direction, currentMap: &currentMap,
            dryRun: false)
          _ = tryToPlaceWide(
            character: otherCharacter, from: otherTarget, direction: direction,
            currentMap: &currentMap,
            dryRun: false)
          currentMap[otherTarget.0][otherTarget.1] = "."
        }
      } else {
        return false
      }
    case "[", "]":
      if tryToPlaceWide(
        character: atTarget, from: target, direction: direction, currentMap: &currentMap,
        dryRun: true)
      {
        if dryRun == false {
          _ = tryToPlaceWide(
            character: atTarget, from: target, direction: direction, currentMap: &currentMap,
            dryRun: false)
        }
      } else {
        return false
      }
    default: ()
    }
    if !dryRun {
      currentMap[target.0][target.1] = character
    }
    return true
  }
}
