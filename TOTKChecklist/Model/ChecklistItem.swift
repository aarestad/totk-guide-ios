import Foundation
import SwiftUI

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
