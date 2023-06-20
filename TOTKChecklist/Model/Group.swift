import Foundation
import SwiftUI

class Group: Identifiable, Codable {
  var id: Int
  var title: AttributedString
  var color: Color
  
  init(id: Int, title: String, color: Color) {
    self.id = id
    self.title = try! AttributedString(markdown: title)
    self.color = color
  }
}
