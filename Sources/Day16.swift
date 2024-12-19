import Collections

private struct Location: Hashable {
  let row: Int
  let col: Int
}

private enum TileType: Hashable {
  case floor
  case wall
}

private enum Direction: Hashable {
  case east
  case west
  case north
  case south
}

private struct State: Hashable {
  let location: Location
  let direction: Direction
}

private struct StateDistance {
  let state: State
  let distance: Int
}

extension StateDistance: Comparable {
  static func < (lhs: StateDistance, rhs: StateDistance) -> Bool {
    lhs.distance < rhs.distance
  }
}

struct Day16: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  private let map: [[TileType]]
  private let start: Location
  private let end: Location

  init(data: String) {
    // paste hardcoded examples here
    /*let data = """
      #################
      #...#...#...#..E#
      #.#.#.#.#.#.#.#.#
      #.#.#.#...#...#.#
      #.#.#.#.###.#.#.#
      #...#.#.#.....#.#
      #.#.#.#.#.#####.#
      #.#...#.#.#.....#
      #.#.#####.#.###.#
      #.#.#.......#...#
      #.#.###.#####.###
      #.#.#...#.....#.#
      #.#.#.#####.###.#
      #.#.#.........#.#
      #.#.#.#########.#
      #S#.............#
      #################
      """*/

    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)

    var start = Location(row: 0, col: 0)
    var end = Location(row: 0, col: 0)
    let lines = data.components(separatedBy: "\n")
    map = lines.enumerated().map { (row, line) in
      line.enumerated().map { (col, character) in
        if character == "#" {
          return TileType.wall
        }
        if character == "S" {
          start = Location(row: row, col: col)
        } else if character == "E" {
          end = Location(row: row, col: col)
        }
        return TileType.floor
      }
    }

    self.start = start
    self.end = end
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var distances: [State: Int] = [:]
    var endDistance: Int = Int.max
    let startState = State(location: start, direction: .east)
    distances[startState] = 0
    var heap = Heap([StateDistance(state: startState, distance: 0)])
    while let from = heap.popMin() {
      if from.state.location == end && endDistance == Int.max {
        endDistance = from.distance
      }
      let delta =
        switch from.state.direction {
        case .east: (0, 1)
        case .west: (0, -1)
        case .north: (-1, 0)
        case .south: (1, 0)
        }
      let forwardRow = from.state.location.row + delta.0
      let forwardCol = from.state.location.col + delta.1
      if map[forwardRow][forwardCol] == .floor {
        let forwardState = State(
          location: Location(row: forwardRow, col: forwardCol), direction: from.state.direction)
        let forwardDistance = from.distance + 1
        if distances[forwardState, default: Int.max] > forwardDistance {
          distances[forwardState] = forwardDistance
          heap.insert(StateDistance(state: forwardState, distance: forwardDistance))
        }
      }
      let turnDirections: [Direction] =
        switch from.state.direction {
        case .east, .west: [.north, .south]
        case .north, .south: [.east, .west]
        }
      for turnDirection in turnDirections {
        let turnState = State(location: from.state.location, direction: turnDirection)
        let turnDistance = from.distance + 1000
        if distances[turnState, default: Int.max] > turnDistance {
          distances[turnState] = turnDistance
          heap.insert(StateDistance(state: turnState, distance: turnDistance))
        }
      }
    }

    return endDistance
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var distances: [State: Int] = [:]
    var endDistance: Int = Int.max
    let startState = State(location: start, direction: .east)
    distances[startState] = 0
    var heap = Heap([StateDistance(state: startState, distance: 0)])
    while let from = heap.popMin() {
      if from.state.location == end && endDistance == Int.max {
        endDistance = from.distance
      }
      let delta =
        switch from.state.direction {
        case .east: (0, 1)
        case .west: (0, -1)
        case .north: (-1, 0)
        case .south: (1, 0)
        }
      let forwardRow = from.state.location.row + delta.0
      let forwardCol = from.state.location.col + delta.1
      if map[forwardRow][forwardCol] == .floor {
        let forwardState = State(
          location: Location(row: forwardRow, col: forwardCol), direction: from.state.direction)
        let forwardDistance = from.distance + 1
        if distances[forwardState, default: Int.max] > forwardDistance {
          distances[forwardState] = forwardDistance
          heap.insert(StateDistance(state: forwardState, distance: forwardDistance))
        }
      }
      let turnDirections: [Direction] =
        switch from.state.direction {
        case .east, .west: [.north, .south]
        case .north, .south: [.east, .west]
        }
      for turnDirection in turnDirections {
        let turnState = State(location: from.state.location, direction: turnDirection)
        let turnDistance = from.distance + 1000
        if distances[turnState, default: Int.max] > turnDistance {
          distances[turnState] = turnDistance
          heap.insert(StateDistance(state: turnState, distance: turnDistance))
        }
      }
    }

    var goodLocations: Set<Location> = Set()
    var queue = Deque(
      distances.filter { state, distance in
        state.location == end && distance == endDistance
      }.keys)
    while !queue.isEmpty {
      let to = queue.removeFirst()
      goodLocations.insert(to.location)
      let delta =
        switch to.direction {
        case .east: (0, -1)
        case .west: (0, 1)
        case .north: (1, 0)
        case .south: (-1, 0)
        }
      let backwardsRow = to.location.row + delta.0
      let backwardsCol = to.location.col + delta.1
      let backwardsState = State(
        location: Location(row: backwardsRow, col: backwardsCol), direction: to.direction)
      if distances[backwardsState] == distances[to]! - 1 {
        queue.append(backwardsState)
      }
      let turnDirections: [Direction] =
        switch to.direction {
        case .east, .west: [.north, .south]
        case .north, .south: [.east, .west]
        }
      for turnDirection in turnDirections {
        let turnState = State(location: to.location, direction: turnDirection)
        if distances[turnState] == distances[to]! - 1000 {
          queue.append(turnState)
        }
      }
    }

    return goodLocations.count
  }
}
