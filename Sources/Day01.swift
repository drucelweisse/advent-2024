import Algorithms

struct Day01: AdventDay {
  static var day: Int { 1 }

  var data: String

  var list: List {
    data
      .split { $0.isNewline }
      .reduce(into: List()) { partialResult, string in
        let splits = string.split { $0.isWhitespace }
        partialResult.left.append(Int(String(splits[0]))!)
        partialResult.right.append(Int(String(splits[1]))!)
      }
  }

  func part1() -> Int {
    let list = list
    let sortedLeft = list.left.sorted()
    let sortedRight = list.right.sorted()

    return zip(sortedLeft, sortedRight).reduce(into: 0) { partialResult, input in
      partialResult += abs(input.1 - input.0)
    }
  }

  func part2() -> Int {
    let list = list
    return list.left.reduce(into: 0) { partialResult, input in
      let similarityScore = list.right.count { $0 == input }
      partialResult += input * similarityScore
    }
  }

  struct List {
    var left: [Int] = []
    var right: [Int] = []
  }
}
