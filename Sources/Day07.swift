import Algorithms

struct Day07: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
    private var equations: [Equation] {
        data.split(separator: "\n").map {
            let components = $0.components(separatedBy: ": ")
            let result = Int(String(components[0]))!
            return Equation(result: result, arguments: components[1].components(separatedBy: .whitespaces).map {
                Int($0)!
            })
        }
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Int {
        equations
            .filter { 
                $0.isValid(index: 1, current: $0.arguments[0]) { current, next in
                    [
                        current + next,
                        current * next,
                    ]
                }
            }
            .reduce(into: 0) { partialResult, equation in
                partialResult += equation.result
            }
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Int {
        equations
            .filter { 
                $0.isValid(index: 1, current: $0.arguments[0]) { current, next in
                    [
                        current + next,
                        current * next,
                        Int("\(current)\(next)")!
                    ]
                }
            }
            .reduce(into: 0) { partialResult, equation in
                partialResult += equation.result
            }
    }
}

struct Equation {
    let result: Int
    let arguments: [Int]

    func isValid(index: Int, current: Int, possibleCombinations: (Int, Int) -> [Int]) -> Bool {
        if index == arguments.count {
            return current == result
        }
        let next = arguments[index]

        return possibleCombinations(current, next).contains { current in
            isValid(index: index + 1, current: current, possibleCombinations: possibleCombinations)
        }
    }
}
