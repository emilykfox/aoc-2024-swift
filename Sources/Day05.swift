import Algorithms

struct Day05: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  var needAfter: [Int: Set<Int>]  // it's an adjacency list!
  let orderings: [[Int]]

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
    let parts = self.data.components(separatedBy: "\n\n")

    needAfter = [:]
    for line in parts[0].split(separator: "\n") {
      let matches = line.firstMatch(of: #/(\d\d)\|(\d\d)/#)!
      let earlier = Int(matches.1)!
      let later = Int(matches.2)!
      needAfter[earlier, default: Set()].insert(later)
    }

    orderings = parts[1].split(separator: "\n").map { line in
      line.split(separator: ",").map { number in Int(number)! }
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var sum = 0

    for ordering in orderings {
      var good = true
      outer: for i in 0..<ordering.count {
        for j in i + 1..<ordering.count {
          if needAfter[ordering[j]]!.contains(ordering[i]) {
            good = false
            break outer
          }
        }
      }
      if good {
        sum += ordering[ordering.count / 2]
      }
    }

    return sum
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() throws -> Any {
    var sum = 0

    // time for lots of tiny topological sorts
    for ordering in orderings {
      var good = true
      outer: for i in 0..<ordering.count {
        for j in i + 1..<ordering.count {
          if needAfter[ordering[j]]!.contains(ordering[i]) {
            good = false
            break outer
          }
        }
      }
      if !good {
        var inDegree: [Int: Int] = [:]
        for i in 0..<ordering.count {
          inDegree[ordering[i]] = 0
        }
        for i in 0..<ordering.count {
          for j in 0..<ordering.count {
            if needAfter[ordering[i]]!.contains(ordering[j]) {
              inDegree[ordering[j]]! += 1
            }
          }
        }

        var newOrdering: [Int] = []
        for _ in 0..<ordering.count {
          let (next, _) = inDegree.first { (key, value) in value == 0 }!
          inDegree[next]! -= 1
          newOrdering.append(next)
          for head in needAfter[next]! {
            inDegree[head]? -= 1
          }
        }

        assert(ordering.count == newOrdering.count)
        sum += newOrdering[ordering.count / 2]
      }
    }

    return sum
  }
}
