import Foundation

class Region: Identifiable, Codable, Hashable {
  init(id: Int, parentRegion: Region? = nil, title: String) {
    self.id = id
    self.parentRegion = parentRegion
    self.title = try! AttributedString(markdown:title)
  }
  
  static func == (lhs: Region, rhs: Region) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  var id: Int
  var parentRegion: Region?
  var title: AttributedString
  
  static let all: Region = Region.init(id:-1, title:"**All**")
}
