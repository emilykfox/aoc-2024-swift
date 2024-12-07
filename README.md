# Advent of Code 2024 in Swift

[![Language](https://img.shields.io/badge/language-Swift-red.svg)](https://swift.org)

Solutions to daily programming puzzles at [Advent of Code](<https://adventofcode.com/>), by
[Eric Wastl](<http://was.tl/>).
Uses the [swift-aoc-starter-example](https://github.com/swiftlang/swift-aoc-starter-example) framework by Tim Sneath.
See its documentation for usage of the framework.

## Solution Notes

### Day 7
An [alternative version](https://github.com/emilykfox/aoc-2024-swift/blob/simpleDay07/Sources/Day07.swift) of Day 7 is available.
The algorithm uses a more straightforward backtracking strategy, but Part Two ends up being slower due to often using three recursive calls per subproblem.
The current solution can sometimes (usually?) get away with one recursive call.
