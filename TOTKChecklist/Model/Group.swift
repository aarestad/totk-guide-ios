import Foundation
import SwiftUI

class Group: Identifiable, Codable {
  var id: Int
  var title: String
  var color: Color? // TODO(aarestad): why isn't color getting persisted
}
