import Testing

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day3Tests {
  // Smoke test data provided in the challenge question
  let testData = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

  let testData2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

  @Test func testPart1() async throws {
    let challenge = Day03(data: testData)
    let data = try challenge.part1()
    #expect(String(describing: data) == "161")
  }

  @Test func testPart2() async throws {
    let challenge = Day03(data: testData2)
    let data = try challenge.part2()
    #expect(try String(describing: data) == "48")
  }
}
