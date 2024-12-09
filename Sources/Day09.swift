import Algorithms

private struct Pair: Hashable {
  let x: Int
  let y: Int
}

struct Day09: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var blocks = data.enumerated().flatMap { (index, size) in
      let size = size.wholeNumberValue!
      let innerBlocks =
        if index % 2 == 0 {
          Array(repeating: index / 2, count: size)
        } else {
          Array(repeating: nil as Int?, count: size)
        }
      return innerBlocks
    }

    var destination = 0
    var source = blocks.count - 1
    while destination < source {
      if blocks[destination] != nil {
        destination += 1
        continue
      }
      if blocks[source] == nil {
        source -= 1
        continue
      }
      blocks[destination] = blocks[source]
      blocks[source] = nil
      destination += 1
      source -= 1
    }

    let checksum = blocks.enumerated().map { (position, id) in
      if id == nil {
        return 0
      } else {
        return position * id!
      }
    }
    .reduce(0, +)

    return checksum
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var spans = data.enumerated().compactMap { (index, size) in
      let size = size.wholeNumberValue!
      let optionalEntry =
        if index % 2 == 0 {
          (index / 2, size)
        } else if size > 0 {
          (nil as Int?, size)
        } else {
          nil as (Int?, Int)?
        }
      return optionalEntry
    }

    let maxID = spans.compactMap { (id, _) in
      id
    }
    .max()!

    for currentID in (0...maxID).reversed() {
      let (oldIndex, oldEntry) = spans.enumerated().first { (index, entry) in entry.0 == currentID
      }!
      let optionalSpace = spans.enumerated().first { (index, entry) in
        entry.0 == nil && entry.1 >= oldEntry.1
      }
      if let (newIndex, destination) = optionalSpace {
        if newIndex < oldIndex {
          spans[oldIndex].0 = nil  // nothing will move into this free space, so no need to combine empty spans
          if destination.1 == oldEntry.1 {
            spans[newIndex].0 = oldEntry.0
          } else {
            spans.insert((nil, destination.1 - oldEntry.1), at: newIndex + 1)
            spans[newIndex].1 = oldEntry.1
            spans[newIndex].0 = oldEntry.0
          }
        }
      }
    }

    var checksum = 0
    var position = 0
    for entry in spans {
      for _ in 0..<entry.1 {
        if let id = entry.0 {
          checksum += position * id
        }
        position += 1
      }
    }

    return checksum
  }
}
