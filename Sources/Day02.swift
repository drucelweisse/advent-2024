import Algorithms

struct Day02: AdventDay {
  var data: String

  var reports: [Report] {
    data
      .split { $0.isNewline }
      .map {
        Report(
          levels: $0.split { $0.isWhitespace }.compactMap {
            Int(String($0))
          })
      }
  }

  func part1() -> Int {
    let thresholdValue = 3
    return reports.count {
      $0.levels.isSafe(thresholdValue: thresholdValue)
    }
  }

  func part2() -> Int {
    let thresholdValue = 3
    return reports.count {
      $0.isSafeRemovingOneElement(thresholdValue: thresholdValue)
    }
  }

  struct Report {
    let levels: [Int]

    func isSafeRemovingOneElement(thresholdValue: Int) -> Bool {
      let isSafe = levels.isSafe(thresholdValue: thresholdValue)

      if isSafe {
        return true
      } else {
        let removed: [[Int]] = levels.enumerated().reduce(into: []) { partialResult, element in
          var copy = levels
          copy.remove(at: element.offset)
          partialResult.append(copy)
        }
        return removed.contains {
          $0.isSafe(thresholdValue: thresholdValue)
        }
      }
    }
  }
}

private enum LevelSort {
  case increasing
  case decreasing
  case same
}

extension [Int] {
  fileprivate func isSafe(thresholdValue: Int) -> Bool {
    var isSafeReport = true
    var sort: LevelSort? = nil
    var currentLevel = self[0]
    for level in self.dropFirst() {
      if sort == nil {
        let currentSort: LevelSort = {
          if level == currentLevel { return .same }
          return level > currentLevel ? .increasing : .decreasing
        }()
        if currentSort == .same {
          isSafeReport = false
          break
        } else {
          sort = currentSort
        }
      } else {
        let currentSort: LevelSort = {
          if level == currentLevel { return .same }
          return level > currentLevel ? .increasing : .decreasing
        }()
        if currentSort == .same {
          isSafeReport = false
          break
        }

        if sort != currentSort {
          isSafeReport = false
          break
        }
      }

      if abs(level - currentLevel) > thresholdValue {
        isSafeReport = false
        break
      }
      currentLevel = level
    }
    return isSafeReport
  }
}
