import Algorithms

private struct Location: Hashable {
  let row: Int
  let col: Int
}

private struct Machine {
  let aX: Int
  let aY: Int
  let bX: Int
  let bY: Int
  let prizeX: Int
  let prizeY: Int
}

struct Day13: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  let data: String
  private let machines: [Machine]

  init(data: String) {
    self.data = data.trimmingCharacters(in: .whitespacesAndNewlines)
    let lines = self.data.components(separatedBy: ("\n"))
    self.machines = (0...(lines.count / 4 as Int)).map { index in
      let aInfo = lines[4 * index].firstMatch(of: #/X\+(\d+), Y\+(\d+)/#)!
      let (aX, aY) = (Int(aInfo.1)!, Int(aInfo.2)!)
      let bInfo = lines[4 * index + 1].firstMatch(of: #/X\+(\d+), Y\+(\d+)/#)!
      let (bX, bY) = (Int(bInfo.1)!, Int(bInfo.2)!)
      let prizeInfo = lines[4 * index + 2].firstMatch(of: #/X=(\d+), Y=(\d+)/#)!
      let (prizeX, prizeY) = (Int(prizeInfo.1)!, Int(prizeInfo.2)!)
      return Machine(aX: aX, aY: aY, bX: bX, bY: bY, prizeX: prizeX, prizeY: prizeY)
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var totalTokens = 0
    for machine in machines {
      var minTokens: Int? = nil
      for numAPresses in 0...100 {
        let remainingX = machine.prizeX - numAPresses * machine.aX
        let remainingY = machine.prizeY - numAPresses * machine.aY
        let numBPresses = remainingX / machine.bX
        if numBPresses >= 0 && numBPresses <= 100 && remainingX == numBPresses * machine.bX
          && remainingY == numBPresses * machine.bY
        {
          let tokens = 3 * numAPresses + numBPresses
          if tokens < minTokens ?? Int.max {
            minTokens = tokens
          }
        }
      }
      totalTokens += minTokens ?? 0
    }

    return totalTokens
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    //return PartUnimplemented(day: 13, part: 2)
    var totalTokens = 0
    for machine in machines {
      // solve 2x2 linear system
      let newbY = machine.bY * machine.aX - machine.aY * machine.bX
      let newprizeY =
        (10_000_000_000_000 + machine.prizeY) * machine.aX - machine.aY
        * (10_000_000_000_000 + machine.prizeX)
      if newbY != 0 {  // unique solutions in rationals
        let numBPresses = newprizeY / newbY
        let numAPresses =
          (10_000_000_000_000 + machine.prizeX - machine.bX * numBPresses) / machine.aX
        if 10_000_000_000_000 + machine.prizeX == numAPresses * machine.aX + numBPresses
          * machine.bX
          && 10_000_000_000_000 + machine.prizeY == numAPresses * machine.aY + numBPresses
            * machine.bY
        {
          totalTokens += 3 * numAPresses + numBPresses
        }
      } else if newprizeY != 0 {  // infinite solutions in rationals
        let maxBPresses = (10_000_000_000_000 + machine.prizeX) / machine.bX
        for reducedPresses in 0..<machine.aX {
          let numBPresses = maxBPresses - reducedPresses
          let numAPresses =
            (10_000_000_000_000 + machine.prizeX - machine.bX * numBPresses) / machine.aX
          if 10_000_000_000_000 + machine.prizeX == numAPresses * machine.aX + numBPresses
            * machine.bX
            && 10_000_000_000_000 + machine.prizeY == numAPresses * machine.aY + numBPresses
              * machine.bY
          {
            totalTokens += 3 * numAPresses + numBPresses
          }
        }
      }
    }

    return totalTokens
  }
}
