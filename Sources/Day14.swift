import Algorithms

private struct Location: Hashable {
  let row: Int
  let col: Int
}

private struct Robot: Hashable {
  let positionX: Int
  let positionY: Int
  let velocityX: Int
  let velocityY: Int
}

struct Day14: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  private let robots: [Robot]

  static let width: Int = 101
  // static let width: Int = 11
  static let height: Int = 103
  // static let height: Int = 7

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
    /*self.data = """
      p=0,4 v=3,-3
      p=6,3 v=-1,-3
      p=10,3 v=-1,2
      p=2,0 v=2,-1
      p=0,0 v=1,3
      p=3,0 v=-2,-2
      p=7,6 v=-1,-3
      p=3,0 v=-1,-2
      p=9,3 v=2,3
      p=7,3 v=-1,2
      p=2,4 v=2,-3
      p=9,5 v=-3,-3
      """*/
    self.robots = self.data.components(separatedBy: "\n").map { line in
      let match = line.firstMatch(of: #/^p=(\d+),(\d+) v=(\-?\d+),(\-?\d+)$/#)!
      return Robot(
        positionX: Int(match.1)!, positionY: Int(match.2)!, velocityX: Int(match.3)!,
        velocityY: Int(match.4)!)
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var locations = robots.map { robot in (robot.positionX, robot.positionY) }
    for _ in 1...100 {
      for robotIndex in 0..<robots.count {
        locations[robotIndex] = (
          (locations[robotIndex].0 + robots[robotIndex].velocityX + Day14.width) % Day14.width,
          (locations[robotIndex].1 + robots[robotIndex].velocityY + Day14.height) % Day14.height
        )
      }
    }

    let safetyFactor = [
      (0, 0), (Day14.width / 2 + 1, 0), (0, Day14.height / 2 + 1),
      (Day14.width / 2 + 1, Day14.height / 2 + 1),
    ].map { (minX, minY) in
      locations.count { (x, y) in
        minX <= x && x < minX + Day14.width / 2 && minY <= y && y < minY + Day14.height / 2
      }
    }.reduce(1, *)

    return safetyFactor
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var locations = robots.map { robot in (robot.positionX, robot.positionY) }
    for seconds in 1...10000 {
      var numPerSpot = Array(
        repeating: Array(repeating: 0, count: Day14.width), count: Day14.height)
      for robotIndex in 0..<robots.count {
        locations[robotIndex] = (
          (locations[robotIndex].0 + robots[robotIndex].velocityX + Day14.width) % Day14.width,
          (locations[robotIndex].1 + robots[robotIndex].velocityY + Day14.height) % Day14.height
        )
        numPerSpot[locations[robotIndex].1][locations[robotIndex].0] += 1
      }

      let likelyTree = numPerSpot.contains {
        $0.reduce(0, +) > Day14.width / 4 && !$0.contains { number in number > 1 }
      }
      if likelyTree {
        print("\(seconds) seconds:")
        let picture = numPerSpot.map { row in
          row.map { number in
            if number == 0 { "." } else { String(number) }
          }.joined()
        }.joined(separator: "\n")
        print(picture)
        print()
      }
    }

    return "Use number of seconds to get a tree."
  }
}
