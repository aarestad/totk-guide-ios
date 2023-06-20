import Foundation
import SwiftUI

struct Coordinate: Hashable, Codable {
  var x: Int
  var y: Int
  var z: Int
}

extension Coordinate: CustomStringConvertible {
  var description: String {
    "(\(x), \(y), \(z))"
  }
}

struct ChecklistItem: Codable, Identifiable, Hashable {
  static func == (lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  var id: Int {
    get {
      location.id
    }
  }

  var location: Location
  var acquired: Bool
}

extension ChecklistItem {
  static let originalData: [ChecklistItem] = initChecklistItems(mapData: initMapData())
}
