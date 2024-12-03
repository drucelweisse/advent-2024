import Algorithms
import RegexBuilder

struct Day03: AdventDay {
  var data: String

  private var multiplications: [Multiplication] {
    get throws {
      let regex = try Regex(#"mul\((\d+),(\d+)\)"#, as: (Substring, Substring, Substring).self)
      return data.matches(of: regex).compactMap { (pair) in
        guard let a = Int(String(pair.1)), let b = Int(String(pair.2)) else { return nil }
        return Multiplication(a: a, b: b)
      }
    }
  }

  private var multiplicationsWithInstructions: [Multiplication] {
    get throws {

      let regex = try Regex(
        #"mul\((\d+),(\d+)\)|don't\(\)|do\(\)"#, as: (Substring, Substring?, Substring?).self)

      var isEnabled = true

      var result = [Multiplication]()

      for match in data.matches(of: regex) {
        if match.output.0 == "don't()" {
          isEnabled = false
        }

        if match.output.0 == "do()" {
          isEnabled = true
        }

        if let a = match.output.1.flatMap({ value in
          Int(String(value))
        }),
          let b = match.output.2.flatMap({ value in
            Int(String(value))
          }), isEnabled
        {
          result.append(Multiplication(a: a, b: b))
        }

      }

      return result

    }
  }

  func part1() throws -> Int {
    try multiplications.map(\.result).reduce(0, +)
  }

  func part2() throws -> Int {
    try multiplicationsWithInstructions.map(\.result).reduce(0, +)
  }
}

private struct Multiplication {
  let a: Int
  let b: Int

  var result: Int {
    a * b
  }
}
